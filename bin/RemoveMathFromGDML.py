#!/usr/bin/env python
#
# Run with '--help' for usage instructions
# 
# Author: Gianluca Petrillo (petrillo@fnal.gov)
# Date:   April 1, 2016
#
# Change log:
# 20160401 [v1.0]  (petrillo@fnal.gov)
#   original version
# 20160401 [v1.1]  (petrillo@fnal.gov)
#   switched default to direct parser;
#   survive with warnings if XML is not available
#   changed the default mode to backup the input and then replace the file;
#   added a single output mode
#

__doc__     = """Evaluates and replaces mathematical expressions from a GDML file.

By default, each of the input file is renamed into a .bak file, and the output
replaces the old file. If no input file is specified, the file is read from standard
input and output to standard output, or to the value of the '--output' option.
The output option can also be specified to set the output file name, in which case
the input file is not renamed. If empty, output will be to standard output.

This scripts supports two modes:
- direct parser: a simple parser that looks for patterns '="xxx"' in a line
  and replaces xxx with its value; it preserves the form of the input,
  but it might silently fail to parse good GDML
- XML parser: a python XML parser evaluates the GDML file completely, then it
  writes it anew; it will parse any XML, but it loses comments and can change
  the order of the attributes
The XML parser is easy to extend to include "define" GDML lines, that are not
currently supported.
"""
__version__ = "1.1"

import sys, os
import logging

try:
   import xml.dom.minidom
   hasXML = True
except ImportError: hasXML = False


###############################################################################
### Expression fixer
###
class GDMLexpressionRemover:
   def __init__(self):
      self.constants = {}
   
   def purify(self, expression):
      # is it a single value?
      try: 
         float(expression)
         return expression
      except ValueError: pass
      
      # is it a valid expression?
      try:
         return eval(expression, self.constants)
      except:
         return expression
   # purify()
   
# class GDMLexpressionRemover



###############################################################################
### Direct text parsing approach 
###
class GDMLpurifier(GDMLexpressionRemover):
   def __init__(self, *args, **kargs):
      GDMLexpressionRemover.__init__(self, *args, **kargs)
   
   @staticmethod
   def findStrings(token):
      """Returns a list of pairs: (prefix, double quoted string)
      
      One of them may be None if no such element is present
      """
      mode = 'p' # 'p': prefix; 'w': word; 'e': equal sign
      tokens = []
      iC = 0
      prefix = ""
      word = None
      for c in token:
         if c == '=':
            if mode == 'p':  # (p) => (e)  on '='
               mode = 'e'
               continue
            # if
         elif c == '"':
            if mode == 'e':  # (e) => (w)  on '"'
               prefix += "="
               word = ""
               mode = 'w'
               continue
            elif mode == 'w': # (w) => (p)  on '"'
               tokens.append((prefix, word))
               prefix = ""
               word = None
               mode = 'p'
               continue
            else: # (p) => (p)  on '"'
               pass
            # if ... else
         else:
            if mode == 'e': # (e) => (p)  on anything but '"'
               mode = 'p'
         # if ... else
         if   mode == 'p': prefix += c
         elif mode == 'w': word += c
      # while
      if prefix or (word is not None):
         tokens.append((prefix, word))
      return tokens
   # findStrings()
   
   def purify(self, expression):
      # is it a single value?
      try: 
         float(expression)
         return expression
      except ValueError: pass
      
      # is it a valid expression?
      try:
         return eval(expression, self.constants)
      except:
         return expression
   # purify()
   
   def apply(self, token, iLine = None):
      """Purifies the token"""
      elements = []
      for prefix, s in self.findStrings(token):
         element = prefix if prefix is not None else ""
         if s is not None:
            purified = self.purify(s)
            if s != purified:
               if iLine is not None:
                  logging.debug(
                    "Evaluated '%s' into '%s' on line %d",
                    s, purified, iLine + 1
                    )
               else:
                  logging.debug("Evaluated '%s' into '%s'", s, purified)
            # if purified
            element += '"' + str(purified) + '"'
         # if s
         elements.append(element)
      # for
      return "".join(elements)
   # apply()
     
# class GDMLpurifier


def RemoveMathFromGDMLfile(InputFileName, OutputFileName = None):
   
   if OutputFileName and (InputFileName == OutputFileName):
      raise RuntimeError \
        ("With the direct parser the input and output file must be different.")
   
   # if InputFileName is empty, use standard input
   InputFile = open(InputFileName, 'r') if InputFileName else sys.stdin
   
   # if OutputFileName is empty, use standard output; otherwise, overwrite
   OutputFile = open(OutputFileName, 'w') if OutputFileName else sys.stdout
   
   RemoveGDMLexpression = GDMLpurifier()
   
   for iLine, line in enumerate(InputFile):
      
      # save indentation
      beef = line.lstrip()
      indent = line[:-len(beef)]
      beef = beef.rstrip() # remove stuff at the end of line too (will be lost)
      
      # we keep the words after removal in a new list
      purified = RemoveGDMLexpression.apply(beef, iLine)
      
      # output accumulates the output line
      output = indent + purified
      print >>OutputFile, output
   # for
   
   if OutputFileName:
      logging.debug("GDML written to file '%s'", OutputFileName)
   
# RemoveMathFromGDMLfile()


###############################################################################
###  XML parsing approach
###
class XMLpurifier(GDMLexpressionRemover):
   def __init__(self, *args, **kargs):
      GDMLexpressionRemover.__init__(self, *args, **kargs)
   
  
   def purifyNode(self, node, level = None):
      """Purifies the attributes in the DOM node"""
      attributes = node.attributes
      if not attributes: return
      for name, value in attributes.items():
         purified = self.purify(value)
         if value != purified:
            logging.debug("Evaluated '%s' into '%s'", value, purified)
            attributes[name] = str(purified)
         # if
      # for attributes
   # purifyNode()
   
# class XMLpurifier


def ApplyToNodes(node, level, func, *args, **kargs):
   """Applies a function to the specified node and all its descendants."""
   if node.childNodes:
      for child in node.childNodes:
         ApplyToNodes(child, level + 1, func, *args, **kargs)
   func(node, level, *args, **kargs)
   
# ApplyToNodes()


def ApplyToDocument(document, func, *args, **kargs):
   ApplyToNodes(document, 0, func, *args, **kargs)


def RemoveMathFromXMLfile(InputFileName, OutputFileName = None):
   
   # if InputFileName is empty, use standard input
   InputFile = open(InputFileName, 'r') if InputFileName else sys.stdin
   
   # parse GDML document using minidom parser
   DOMTree = xml.dom.minidom.parse(InputFile)
   GDML = DOMTree.documentElement
   
   RemoveGDMLexpression = XMLpurifier()
   
   ApplyToDocument(GDML, RemoveGDMLexpression.purifyNode)
   
   # if OutputFileName is empty, use standard output; otherwise, overwrite
   OutputFile = open(OutputFileName, 'w') if OutputFileName else sys.stdout
   
   OutputFile.write(GDML.toxml())
   OutputFile.write("\n")
   
   if OutputFileName:
      logging.debug("GDML written to file '%s'", OutputFileName)
   
# RemoveMathFromXMLfile()


################################################################################
def LoggingSetup(LoggingLevel = logging.INFO):

   logging.basicConfig(
     level=LoggingLevel,
     format="%(levelname)s: %(message)s",
     stream=sys.stderr # do not pollute standard output
     )

# def LoggingSetup()


def RunParserOn(parser, InputFileName):
   """Renames the input file into '.bak', then runs the parser"""
   
   OldInputFileName = InputFileName
   InputFileName += ".bak"
   OutputFileName = OldInputFileName
   
   # rename the input file
   if os.path.exists(InputFileName):
      raise RuntimeError(
        "Backup file '%s' is on the way. Please remove it first."
        % InputFileName
        )
   # if exists
   logging.debug("Renaming the input file into '%s'", InputFileName)
   os.rename(OldInputFileName, InputFileName)

   # run the parser
   try:
      parser(InputFileName, OutputFileName)
   except Exception, e:
      # if no output file was produced, rename back the input
      if not os.path.exists(OutputFileName):
         logging.debug("Restoring the input file name after a fatal error.")
         os.rename(InputFileName, OldInputFileName) 
      raise e
   # try ... except
   
   logging.info("File '%s' rewritten (old file in '%s')",
     OutputFileName, InputFileName
     )
   
# RunParserOn()


################################################################################
def RemoveMathFromGDML():
   import argparse
   
   LoggingSetup(logging.WARN)
   
   # the first parser is the default one
   SupportedParsers = [ 'direct', 'xml', 'list' ]
   if not hasXML:
      logging.warn("XML parser is not supported (cam't find python XML module)")
      SupportedParsers.remove('xml')
   # if
   
   parser = argparse.ArgumentParser(description=__doc__)

   parser.add_argument("InputFiles", nargs="*", default=None,
     help="input GDML files [default: stdin]")

   parser.add_argument("--parser", choices=SupportedParsers,
     dest="Parser", default=SupportedParsers[0],
     help="choose which parser to use ('list' for a list) [%(default)s]")
   
   parser.add_argument("--direct", action="store_const", const="direct",
     dest="Parser", help="use simple internal parser [%(default)s]")
   
   parser.add_argument("--xml", action="store_const", const="xml",
     dest="Parser", help="use complete XML parser [%(default)s]")

   parser.add_argument("--output", dest="OutputFile", default=None,
     help="for a single input, use this as output file")
   
   parser.add_argument('--verbose', '-v', dest="DoVerbose", action='store_true',
     help="shows all the changes on screen [%(default)s]")
   parser.add_argument('--debug', dest="DoDebug", action='store_true',
     help="enables debug messages on screen")

   parser.add_argument('--version', action='version',
     version='%(prog)s ' + __version__)

   arguments = parser.parse_args()
   
   # set up the logging system
   logging.getLogger().setLevel \
     (logging.DEBUG if arguments.DoDebug else logging.INFO)

   arguments.LogMsg = logging.info if arguments.DoVerbose else logging.debug
   

   if arguments.Parser == 'list':
      SupportedParsers.remove('list')
      logging.info("Supported parsers: '%s'.", "', '".join(SupportedParsers)) 
      return 0
   # if list parsers
   
   if arguments.Parser == 'direct':
      Parser = RemoveMathFromGDMLfile
   elif arguments.Parser == 'xml':
      Parser = RemoveMathFromXMLfile
   else:
      raise RuntimeError("Unexpected parser '%s' requested", arguments.Parser)
   
   if not arguments.InputFiles:
      Parser(None)
   elif arguments.OutputFile is not None:
      if len(arguments.InputFiles) > 1:
         raise RuntimeError \
           ("Named output is supported only when a single input file is specified.")
      # if
      Parser(arguments.InputFiles[0], arguments.OutputFile)
   else:
      for InputFileName in arguments.InputFiles:
         RunParserOn(Parser, InputFileName)
   # if ... else
   
   
   return 0
# RemoveMathFromGDML()


################################################################################
if __name__ == "__main__":

   sys.exit(RemoveMathFromGDML())
# main

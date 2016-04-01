#!/usr/bin/env python
#
# Author: Gianluca Petrillo (petrillo@fnal.gov)
# Date:   April 1, 2016
#

__doc__     = """Evaluates and replaces mathematical expressions from a GDML file.

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
__version__ = "1.0"

import sys
import logging

import xml.dom.minidom


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


################################################################################
def RemoveMathFromGDML():
   import argparse

   parser = argparse.ArgumentParser(description=__doc__)

   parser.add_argument("InputFile", nargs="?", default=None,
     help="input GDML file [default: stdin]")

   parser.add_argument("OutputFile", nargs="?", default=None,
     help="output GDML file (will be overwritten) [stdout]")
   
   parser.add_argument("--direct", action="store_true", default=False,
     dest="UseSimpleParser", help="use simple internal parser [%(default)s]")
   
   parser.add_argument('--verbose', '-v', dest="DoVerbose", action='store_true',
     help="shows all the changes on screen [%(default)s]")
   parser.add_argument('--debug', dest="DoDebug", action='store_true',
     help="enables debug messages on screen")

   parser.add_argument('--version', action='version',
     version='%(prog)s ' + __version__)

   arguments = parser.parse_args()

   # set up the logging system
   LoggingSetup(logging.DEBUG if arguments.DoDebug else logging.INFO)

   if arguments.DoVerbose: arguments.LogMsg = logging.info
   else:                   arguments.LogMsg = logging.debug

   if arguments.UseSimpleParser:
      RemoveMathFromGDMLfile(arguments.InputFile, arguments.OutputFile)
   else:
      RemoveMathFromXMLfile(arguments.InputFile, arguments.OutputFile)

   return 0
# RemoveMathFromGDML()


################################################################################
if __name__ == "__main__":

   sys.exit(RemoveMathFromGDML())
# main

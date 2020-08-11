#!/usr/bin/env python
#
# Run with `--help` for usage instructions
# 
# Changes:
# 20200714 (petrillo@slac.stanford.edu) [v2.0]
#   updated to Python 3
#

__doc__     = "Performs hard-coded substitutions on all files in a directory."
__version__ = '2.0'

import sys, os
import logging
import re
import shutil
import tempfile

def ANSIcode(content): return "\x1B[" + content + "m"

ANSIReset = ANSIcode("0")
ANSIRed        = ANSIcode("31")
ANSIGreen      = ANSIcode("32")
ANSIBlue       = ANSIcode("34")
ANSIBrightBlue = ANSIcode("1;34")
ANSIMagenta    = ANSIcode("35")
ANSIYellow     = ANSIcode("1;33")
ANSIWhite      = ANSIcode("1;37")

################################################################################
### Library code
###
def Colorize(msg, category, options):
	if not options or not options.UseColor: return str(msg)
	return options.Colors.get(category, "") + str(msg) + ANSIReset
# Colorize()


class ContextClass:
	
	def __init__(self): self.options = None
	
	def SetOptions(self, options): self.options = options
	
	def Location(self): return "(no context)"
	def __str__(self): return self.Location()
	
# class ContextClass

class LineNoContextClass(ContextClass):
	def __init__(self, filename, line_no):
		ContextClass.__init__(self)
		self.filename = filename
		self.SetLine(line_no)
	# __init__()
	
	def Location(self):
		return "%s@%s" % (
			Colorize(self.filename, 'source', self.options),
			Colorize(self.line_no, 'line_no', self.options)
			)
	
	def SetLine(self, line_no): self.line_no = line_no
	
# class LineNoContextClass


class SubstitutionClass:
	
	def __init__(self): self.options = None
	
	def SetOptions(self, options): self.options = options
	
	def __str__(self): return "<no substitution>"
	
	def __call__(self, s, context = None): return s
	
	def describe(self): return str(self)
	
# class SubstitutionClass


class RegExSubstitutionClass(SubstitutionClass):
	def __init__(self, match, replacement, exceptions = []):
		SubstitutionClass.__init__(self)
		self.regex = re.compile(match)
		self.repl = replacement
		self.exceptions = list(map(re.compile, exceptions))
	# __init__()
	
	def __str__(self): return self.regex.pattern
	
	def __call__(self, s, context = None):
		for pattern in self.exceptions:
			if pattern.search(s) is not None: return s
		return self.regex.sub(self.repl, s)
	
	def Describe(self):
		return "%r -> %r (regex)" % (self.regex.pattern, self.repl)
	
# class RegExSubstitutionClass


class RegExDeleteLineClass(SubstitutionClass):
	def __init__(self, match, exceptions = []):
		SubstitutionClass.__init__(self)
		self.regex = re.compile(match)
		self.exceptions = list(map(re.compile, exceptions))
	# __init__()
	
	def __str__(self): return self.regex.pattern
	
	def __call__(self, s, context = None):
		for pattern in self.exceptions:
			if pattern.search(s) is not None: return s
		if self.regex.match(s): return []
		return s
	# __call__
	
	def Describe(self):
		return "%r (remove)" % (self.regex.pattern, )
	
# class RegExDeleteLineClass


class ReplacementClass(SubstitutionClass):
	def __init__(self, match, replacement, exceptions = []):
		SubstitutionClass.__init__(self)
		self.pattern = match
		self.repl = replacement
		self.exceptions = exceptions
	# __init__()
	
	def __str__(self): return self.pattern
	
	def __call__(self, s, context = None):
		for pattern in self.exceptions:
			if pattern in s: return s
		return s.replace(self.pattern, self.repl)
	# __call__()
	
	def Describe(self):
		return "%r -> %r (literal)" % (self.pattern, self.repl)
	
# class ReplacementClass


class WarningClass(SubstitutionClass):
	def __init__(self, match, message, exceptions = []):
		SubstitutionClass.__init__(self)
		if hasattr(match, 'search'):
			self.pattern = match.pattern
			self.regex = match
		else:
			self.pattern = match
			self.regex = re.compile(match)
		self.msg = message
		self.exceptions = list(map(re.compile, exceptions))
	# __init__()
	
	def __str__(self): return self.pattern
	
	def __call__(self, s, context = None):
		for pattern in self.exceptions:
			if pattern.search(s) is not None: return s
		match = self.regex.search(s)
		if match is not None:
			msg = match.expand(self.msg)
			if context is None:
				logging.warning(
				  "From line '%s': %s", s,
				  Colorize(msg, 'warning', self.options)
				  )
			else:
				logging.warning(
				  "From %s: %s\n  => %s",
				  context.Location(), Colorize(msg, 'warning', self.options), s
				  )
			# if ... else
			logging.debug("(pattern: %r on %r)", self.regex.pattern, s)
		# if
		return s
	# __call__()
	
	def Describe(self):
		return "%r -> %r (warning)" % (self.pattern, self.msg)
	
# class WarningClass




class ProcessorClass:
	def __init__(self, name):
		"""Supported keyword arguments: "options"
		"""
		self.name = name
		self.options = None
		self.file_filters = []
		self.patterns = []
	# __init__()
	
	def SetOptions(self, options):
		self.options = options
		for pattern in self.patterns: pattern.SetOptions(options)
		return self
	# SetOptions()
	
	def SetColors(self, **colors):
		try: self.options.Colors.update(colors)
		except AttributeError: self.options.Colors = colors
	# SetColors()
	
	def Color(self, msg, category): return Colorize(msg, category, self.options)
	
	def RecordPattern(self, pattern):
		pattern.SetOptions(self.options)
		self.patterns.append(pattern)
	# RecordPattern()
	
	
	def AddFilePattern(self, pattern):
		if not pattern.endswith('$'): pattern += "$"
		match = re.compile(pattern)
		self.file_filters.append(match)
		return self
	# AddFilePattern()
	
	def AddFileNamePattern(self, name_pattern):
		return self.AddFilePattern(R"(.*/)*" + name_pattern)
	
	def AddFileType(self, *suffixes):
		for suffix in suffixes: self.AddFileNamePattern(".*\." + suffix)
		return self
	# AddFileType()
	
	
	def AddRegExPattern(self, pattern, repl, exceptions = []):
		self.RecordPattern(RegExSubstitutionClass(pattern, repl, exceptions))
		return self
	# AddRegExPattern()
	
	def AddRegExRemoveLine(self, pattern, exceptions = []):
		self.RecordPattern(RegExDeleteLineClass(pattern, exceptions))
		return self
	# AddRegExRemoveLine()
	
	def AddSimplePattern(self, pattern, repl, exceptions = []):
		self.RecordPattern(ReplacementClass(pattern, repl, exceptions))
		return self
	# AddSimplePattern()
	
	def AddWord(self, word, repl, exceptions = []):
		return self.AddRegExPattern(r'\b' + word + r'\b', repl, exceptions)
	
	def AddWarningPattern(self, pattern, msg, exceptions = []):
		self.RecordPattern(WarningClass(pattern, msg, exceptions))
		return self
	# AddWarningPattern()
	
	def AddPattern(self, pattern, repl, exceptions=[]):
		return self.AddRegExPattern(pattern, repl, exceptions)
	
	
	def MatchFile(self, FilePath):
		if not self.file_filters: return True
		for pattern in self.file_filters:
			if pattern.match(FilePath) is None: continue
		#	logging.debug("Matched pattern: '%s'", pattern.pattern)
			return True
		# for
		return False
	# MatchFile()
	
	def SubstituteLine(self, line, context = None):
		"""Returns the very same string if the new line is the same as the old one
		or a list of lines to replace line with
		"""
		if line is None: return line
		
		for subst in self.patterns:
			new_line = subst(line, context)
			if new_line is line: continue
			
			msg = "    pattern '%s' matched" % subst
			if context is not None: msg += " at %s" % context
			msg += ":"
			if isinstance(new_line, str):
				msg += "\n    OLD| " + self.Color(line.rstrip('\n'), 'old')
				msg += "\n    NEW| %s" % self.Color(new_line.rstrip('\n'), 'new')
			elif not new_line:
				msg += "\n    DEL| %s" % self.Color(line.rstrip('\n'), 'old')
			else:
				msg += "\n    OLD| " + self.Color(line.rstrip('\n'), 'old')
				for l in new_line:
					msg += "\n    NEW| %s" % self.Color(l.rstrip('\n'), 'new')
			# if ... else
			self.options.LogMsg(msg)
			
			# if the result if not a single line, we interrupt here;
			# no particular reason, but we don't need a more complex behaviour
			if not isinstance(new_line, str): return new_line
			
			line = new_line
		# for
		return line
	# SubstituteLine()
	
	def ProcessFile(self, FilePath):
		"""Returns whether substitutions were performed"""
		if not self.patterns: return False
		
	#	logging.debug("Considering file: '%s'", FilePath)
		
		# filter by file name/path
		if not self.MatchFile(FilePath): return False
		
		# replace in memory, line by line
		context = LineNoContextClass(FilePath, 0)
		context.SetOptions(self.options)
		Content = []
		nChanges = 0
		SourceFile = open(FilePath, 'r')
		for iLine, line in enumerate(SourceFile):
			context.SetLine(iLine + 1)
			new_line = self.SubstituteLine(line, context)
			if new_line is line:
				Content.append(line)
				continue
			# if no change
			if isinstance(new_line, str):
				Content.append(new_line)
			elif new_line: # expects a list or None
				Content.extend(new_line)
			# if .. else
			nChanges += 1
		# for
		SourceFile.close()
		# if substitutions have been not performed, return
		if nChanges == 0:
			logging.debug("No changes in '%s'.", FilePath)
			return False
		logging.debug("%d lines changed in '%s'.", nChanges, FilePath)
		
		if self.options.DoIt:
			# create the new file
			OutputFile = ProcessorClass.CreateTempFile(FilePath)
			OutputPath = OutputFile.name
		#	logging.debug("  (temporary file: '%s')", OutputPath)
			OutputFile.write("".join(Content))
			OutputFile.close()
			shutil.copymode(FilePath, OutputPath)
			
			# if we are still alive, move the new file in place of the old one
			shutil.move(OutputPath, FilePath)
		# if
		
		return True
	# ProcessFile()
	
	def ProcessFiles(self, *files):
		nChanged = 0
		for FilePath in files:
			if self.ProcessFile(FilePath): nChanged += 1
		# for files
		return nChanged
	# ProcessFiles()
	
	def ProcessDir(self, DirPath):
		"""Returns the number of files processor actually acted on"""
		nActions = 0
		if os.path.isdir(DirPath):
			for dirpath, dirnames, filenames in os.walk(DirPath):
				filepaths \
				  = [ os.path.join(dirpath, filename) for filename in filenames ]
				nChanged = self.ProcessFiles(*filepaths)
				if nChanged > 0:
					logging.debug("  processor '%s' changed %d files in '%s'",
					  self.name, nChanged, dirpath
					  )
				# if
				nActions += nChanged
			# for
			if nActions > 0:
				ApplyChangesMsg = "changed" if self.options.DoIt else "would change"
				logging.info("Processor '%s' %s %d files in '%s'",
				  self.name, ApplyChangesMsg, nActions, DirPath
				  )
			# if nActions
		else:
			if self.ProcessFile(DirPath):
				ApplyChangesMsg = "changed" if self.options.DoIt else "would change"
				logging.info("Processor '%s' %s file '%s'",
				  self.name, ApplyChangesMsg, DirPath
				  )
				nActions += 1
			# if
		# if ... else
		return nActions
	# ProcessDir()

	def __str__(self): return self.name
	
	def Describe(self):
		output = [
			"Processor '%s' applies %d substitutions" % (self, len(self.patterns))
		]
		for subst in self.patterns:
			try: output.append("  " + subst.Describe())
			except AttributeError:
				output.append("  " + str(subst))
			except: 
				output.append("  " + repr(subst))
		# for
		return output
	# Describe()
	
	@staticmethod
	def CreateTempFile(FilePath):
		TempPath = os.path.join(
		  tempfile.gettempdir(),
		  tempfile.gettempprefix() + "-" + os.path.basename(FilePath) + ".tmp"
		  )
		TempFile = open(TempPath, 'w')
		return TempFile
	# CreateTempFile()
	
# class ProcessorClass



class ProcessorsList:
	def __init__(self):
		self.options = None
		self.processors = []
	# __init__()
	
	def __iter__(self): return iter(self.processors)
	def __len__(self): return len(self.processors)
	
	def SetOptions(self, options):
		self.options = options
		for processor in self: processor.SetOptions(options)
	
	def SetColors(self, **colors):
		for processor in self: processor.SetColors(**colors)
	
	def SelectProcessors(self, ProcessorNames):
		if ProcessorNames is None: return
		selected = []
		for ProcessorName in ProcessorNames:
			for Processor in self.processors:
				if Processor.name != ProcessorName: continue
				selected.append(Processor)
				break
			else:
				raise RuntimeError \
				  ("Unknown processor '%s' selected" % ProcessorName)
			# for ... else
		# for processor names
		self.processors = selected
	# SelectedProcessors()
	
	def ProcessDir(self, DirPath):
		ApplyChangesMsg = "changed" if self.options.DoIt else "would be changed"
		nChanged = 0
		for processor in self: nChanged += processor.ProcessDir(DirPath)
		logging.info("%d file %s under '%s'", nChanged, ApplyChangesMsg, DirPath)
		return nChanged
	# ProcessDir()
	
	def AddProcessor(self, processor):
		self.processors.append(processor)
		return processor
	# AddProcessor()
	
	def Describe(self):
		output = [ "There are %d processors in queue" % len(self) ]
		for processor in self:
			output.extend(processor.Describe())
		return output
	# Describe()
	
	
# class ProcessorsList
ProcessorsList.Global = ProcessorsList()


def AddProcessor(processor):
	return ProcessorsList.Global.AddProcessor(processor)


def LoggingSetup(LoggingLevel = logging.INFO):
	
	logging.basicConfig(
	  level=LoggingLevel,
	  format="%(levelname)s: %(message)s"
	  )
	
# def LoggingSetup()

################################################################################
def RunSubstitutor():
	import argparse
	
	parser = argparse.ArgumentParser(description=__doc__)
	
	parser.add_argument("InputDirs", nargs="*", action="store",
	  help="input directories [current]")
	
	parser.add_argument('--doit', dest="DoIt", action='store_true',
	  help="perform the substitutions [%(default)s]")
	
	parser.add_argument('--verbose', '-v', dest="DoVerbose", action='store_true',
	  help="shows all the changes on screen [%(default)s]")
	parser.add_argument('--debug', dest="DoDebug", action='store_true',
	  help="enables debug messages on screen")
	parser.add_argument('--color', '-U', dest="UseColor", action='store_true',
	  help="enables coloured output [%(default)s]")
	
	parser.add_argument('--list', dest="DoList", action='store_true',
	  help="just prints the hard-coded substitutions for each processor")
	parser.add_argument('--only', dest="SelectedProcessors", action='append',
	  help="executes only the processors with the specified name (see --list)")
	parser.add_argument('--version', action='version',
	  version='%(prog)s ' + __version__)
	
	arguments = parser.parse_args()
	
	# set up the logging system
	LoggingSetup(logging.DEBUG if arguments.DoDebug else logging.INFO)
	
	if arguments.DoVerbose: arguments.LogMsg = logging.info
	else:                   arguments.LogMsg = logging.debug
	
	Processors = ProcessorsList.Global # use the global list
	
	Processors.SetOptions(arguments)
	Processors.SetColors(
	  old=ANSIRed, new=ANSIGreen, source=ANSIWhite, line_no=ANSIMagenta,
	  warning=ANSIYellow
	  )
	if arguments.SelectedProcessors:
		Processors.SelectProcessors(arguments.SelectedProcessors)
	
	if arguments.DoList:
		logging.info("\n".join(Processors.Describe()))
		sys.exit(0)
	# if
	
	
	if not arguments.InputDirs: arguments.InputDirs = [ '.' ]
	
	for InputPath in arguments.InputDirs:
		Processors.ProcessDir(InputPath)
	
	return 0
# RunSubstitutor()


################################################################################
if __name__ == "__main__":
	
	#############################################################################
	# Test
	#
	subst = AddProcessor(ProcessorClass("subst"))
	
	subst.AddPattern     (r"[^\w]", r"_" )
	subst.AddSimplePattern("A",  "a")
	
	sys.exit(RunSubstitutor())
# main

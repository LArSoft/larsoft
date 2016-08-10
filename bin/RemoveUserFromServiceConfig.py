#!/usr/bin/env python2

import sys, re

import SerialSubstitution
from SerialSubstitution import AddProcessor, RunSubstitutor


################################################################################
if __name__ == "__main__":
	
	#############################################################################
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
	# All files (no file selection)
	#
	Subst = AddProcessor(SerialSubstitution.ProcessorClass("FHiCL"))
	
	Subst.AddRegExRemoveLine(r"\s*user\s*:\s*\{\s*\}\s*")
	Subst.AddRegExPattern   (r"user:(\s+)@local::",          r"     \1@table::")
	Subst.AddRegExPattern   (r"user:(\s+)\{\s*(.*)\s*\}\s*", r"\2")
	Subst.AddSimplePattern   ("services.user.",               "services.")
	
	Subst.AddWarningPattern (r"user\s*:", "Manual intervention may be required")
	
	
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
	#############################################################################
	
	sys.exit(RunSubstitutor())
# 

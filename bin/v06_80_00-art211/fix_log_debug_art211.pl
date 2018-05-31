
use strict;
use warnings;

if( $#ARGV < 0 ) {
    print "\n";
    print "USAGE: fix_log_debug_art211.pl <input-file>\n";
    print "\n";
    exit 1;
}

my $inputfile = $ARGV[0];
my $outputfile = $inputfile.".new";

print "check $inputfile for LOG_DEBUG\n";
open(PIN, "< $inputfile") or die "Couldn't open $inputfile";
open(POUT, "> $outputfile") or die "Couldn't open $outputfile";
my $line;
while ( $line=<PIN> ) {
  chop $line;
  if (( $line =~ m/LOG_DEBUG/ ) && ( $line =~ m/<</ )) {
    if ( $line =~ m/^\/\// ) {
      print POUT "$line\n";
    } else {
      print "updating $line\n";
      print POUT "// workaround for #19851\n";
      print POUT "//$line\n";
      $line =~ s/LOG_DEBUG/mf::LogDebug/;
      print POUT "$line\n";
    }
  } else {
     print POUT "$line\n";
  }
  
}
close(PIN);
close(POUT);

exit(0);

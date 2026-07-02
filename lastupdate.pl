#!perl
#
# Update the last update timestamp on an html page
# Follow this format:
# <p><span style="background: #FFFFdd">Last update: Wed, Jul 1, 2026 4:36 pm EDT</span></p>
#
# Usage: ./lastupdate.pl index.html bios.html ...

# Source - https://stackoverflow.com/a/31025531
# Posted by Borodin
# Retrieved 2026-07-01, License - CC BY-SA 3.0

use strict;
use warnings;

my $tmpfile_suffix = ".bak";
my $tmpfile;

use POSIX qw(strftime);
my $localtime = strftime "%a, %b %e, %Y %l:%M %p %Z", localtime;

print "Localtime: $localtime\n";

foreach my $file (@ARGV){

  print "Processing $file\n";

  $tmpfile = "$file$tmpfile_suffix";

  open(IN,$file) or die "open($file,r): $!";
  open(OUT,">",$tmpfile) or die "open($tmpfile,w): $!";

  while ( <IN> ) {
     print OUT;
  }

  close IN;
  close OUT;

 # return flow
  open(IN,$tmpfile) or die "open($tmpfile,r): $!";
  open(OUT,">",$file) or die "open($file,w): $!";

  while ( <IN> ) {
     s/Last update: \w+, \w+  ?\d+, \d{4}  ?[\d:]+ ?((a|p|A|P)(m|M))? \w{3}/Last update: $localtime/;
     print OUT;
  }

  close IN;
  close OUT;
}

print "Processed: @ARGV\n";


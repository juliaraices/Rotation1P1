#!/usr/bin/perl
print "make sure your input file is sorted by scaffoldname! sort -k 10";
my $input = $ARGV[0]; # reads input given after calling the program

open (INPUT, "$input"); # opens input
open (RESULTS, ">$input.besthit"); # creates and opens output file

print RESULTS "1match\tmismatch\trep\tNs\tQgapcount\tQgapbases\tTgapcount\tTgapbases\tstrand\tQname\tQsize\tQstart\tQend\tTname\tTsize\tTstart\tTend\tblockcount\tblockSizes\tqStarts\ttStarts\n"; # prints header to output file

$name0="";
$score0=0;
$line0="";

while ($line = <INPUT>) { # reads line by line
($match, $mismatch, $rep, $Ns, $Qgapcount, $Qgapbases, $Tgapcount, $Tgapbases, $strand, $Qname, $Qsize, $Qstart, $Qend, $Tname, $Tsize, $Tstart, $Tend, $blockcount, $blockSizes, $qStarts, $tStarts)=split(/\t/, $line);
# splits lines in tabs	
	if ($Qname eq $name0) # if the name of  the contig is the same as  the previous contig
		{
		if ($match > $score0) # if this contigs match is higher than the current one
			{
			$name0=$Qname; # replace it all for the current one
			$score0=$match;
			$line0=$line;
			}
		else # else do nothing
			{
			}

		}
	else # else (different contig)
		{
		print RESULTS $line0; # print previous results
		$name0=$Qname; # replace old contig by new contig
                $score0=$match;
                $line0=$line;

		}
		
	
	}
	# after all lines have ben read
print RESULTS $line0; # print the last contig

system "perl -pi -e 's/^[^0-9].*//gi' $input.besthit";
system "perl -pi -e 's/1match/match/gi' $input.besthit";
system "perl -pi -e 's/^\n//gi' $input.besthit"; # remove empty line at the end

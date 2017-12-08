#!/usr/local/bin/perl

print "make sure you've sorted your input file by contig name!\n";

my $input = $ARGV[0];

open (INPUT, "$input") or die "where is input, dummy?"; 
open (RESULT, ">>$input.bestlocation");

$contig0="contig0";
$count=0;
$totscore=0;
$chromname="whatevah";
$c1count=0;
$c1score=0;
$c2count=0;
$c2score=0;
$c3count=0;
$c3score=0;
$c4count=0;
$c4score=0;
$c5count=0;
$c5score=0;
$c6count=0;
$c6score=0;




while ($line = <INPUT>) {
	chomp $line;

	($contig, $gene, $chrom, $score) = split(/\s/, $line);
	print "$contig0 $contig $chrom\n";

	if ($contig eq $contig0)
		{
		print "the same!\n";
		#find which chrom it is
		#add 1 to that chrom's count
		#add score to that chrom's score
		
		if ($chrom =~ /2L/) { $c2Lcount++; $c2Lscore=$c2Lscore+$score; }
		elsif ($chrom =~ /2R/) { $c2Rcount++; $c2Rscore=$c2Rscore+$score; }
		elsif ($chrom =~ /3L/) { $c3Lcount++; $c3Lscore=$c3Lscore+$score; }
		elsif ($chrom =~ /3R/) { $c3Rcount++; $c3Rscore=$c3Rscore+$score; }
		elsif ($chrom =~ /X/) { $cXcount++; $cXscore=$cXscore+$score; }
		elsif ($chrom =~ /4/) { $c4count++; $c4score=$c4score+$score; }
		else {}		
		
		$contig0=$contig;

		}
	else 

		{
		print "different!\n";
		#new contig
		#first output results for previous contig, contig0
		
		print "$contig0 $c2Lcount $c2Rcount $c3Lcount $c3Rcount $cXcount  $c4count\n";
		
		$countsum=$c2Lcount+$c2Rcount+ $c3Lcount+$c3Rcount+$cXcount+$c4count;

		if ($countsum > 0) 
			{
		
			$count=$c2Lcount;
			$totscore=$c2Lscore;
			$chromname="2L";
			
		
			if ($c2Rcount == $count) {if ($c2Rscore >= $totscore ) {$count=$c2Rcount; $totscore=$c2Rscore; $chromname="2R";} else {}} 
			elsif ($c2Rcount > $count) {$count=$c2Rcount; $totscore=$c2Rscore; $chromname="2R";} 
			else {}
			
			if ($c3Lcount == $count) {if ($c3Lscore >= $totscore ) {$count=$c3Lcount; $totscore=$c3Lscore; $chromname="3L";} else {}}
			elsif ($c3Lcount > $count) {$count=$c3Lcount; $totscore=$c3Lscore; $chromname="3L";} 	
			else {}
	
			if ($c3Rcount == $count) {if ($c3Rscore >= $totscore ) {$count=$c3Rcount; $totscore=$c3Rscore; $chromname="3R";} else {}}
			elsif ($c3Rcount > $count) {$count=$c3Rcount; $totscore=$c3Rscore; $chromname="3R";} 
			else {}

			if ($cXcount == $count) {if ($cXscore >= $totscore ) {$count=$cXcount; $totscore=$cXscore; $chromname="X";} else {}}
			elsif ($cXcount > $count) {$count=$cXcount; $totscore=$cXscore; $chromname="X";} 
			else {}

			if ($c4count == $count) {if ($c4score >= $totscore ) {$count=$c4count; $totscore=$c4score; $chromname="4";} else {}}
			elsif ($c4count > $count) {$count=$c4count; $totscore=$c4score; $chromname="4";} 	
			else {}	
		
			print RESULT "$contig0\t$chromname\t$count\t$totscore\n";
			}
		#and empty all the variables we've outputed. 
		$count=0;
		$totscore=0;
		$chromname="whatevah";
		$c2Lcount=0;
		$c2Lscore=0;
		$c2Rcount=0;
		$c2Rscore=0;
		$c3Lcount=0;
		$c3Lscore=0;
		$c3Rcount=0;
		$c3Rscore=0;
		$cXcount=0;
		$cXscore=0;
		$c4count=0;
		$c4score=0;


		#now start processing new contig

		$contig0=$contig;

		if ($chrom =~ /2L/) { $c2Lcount++; $c2Lscore=$c2Lscore+$score; }
		elsif ($chrom =~ /2R/) { $c2Rcount++; $c2Rscore=$c2Rscore+$score; }
		elsif ($chrom =~ /3L/) { $c3Lcount++; $c3Lscore=$c3Lscore+$score; }
		elsif ($chrom =~ /3R/) { $c3Rcount++; $c3Rscore=$c3Rscore+$score; }
		elsif ($chrom =~ /X/) { $cXcount++; $cXscore=$cXscore+$score; }
		elsif ($chrom =~ /4/) { $c4count++; $c4score=$c4score+$score; }
		else {}		

		}

	
}


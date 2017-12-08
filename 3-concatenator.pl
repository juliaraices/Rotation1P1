#!/usr/bin/perl

#this program takes all the scaffolds that map to the same gene
#and concatenates them
#input file should be: scafold blatscore scaflength gene genelength genestart geneend strand
# OLD PARAMETERS and should be sorted by gene and within gene by genestart (-k4,4 -k6,6n)
#NOW--> sort k14,14 -k16,16 blabla.blat.sorted.besthit.sortedbyDB.nonredundant >  blabla.inputforconcat
#the other input file is the fasta file containing the scaffolds

#usage perl concatenator scaffoldfastafile inputfile

my $fasta = $ARGV[0];
my $blat= $ARGV[1];

open(BLAT, "$blat");
open(RESULTS, ">$blat.fasta");
$name0="name00000";



while ($line = <BLAT>)
	 {
	# this line no longer used ($scaf, $score, $scaflength, $gene, $genelength, $genestart, $geneend, $strand) = split(" ", $line);
	($score, $mismatch, $rep, $Ns, $Qgapcount, $Qgapbases, $Tgapcount, $Tgapbases, $strand, $scaf, $scaflength, $Qstart, $Qend, $gene, $genelength, $genestart, $geneend, $blockcount, $blockSizes, $qStarts, $tStarts)=split(/\t/, $line);

	if ($gene eq $name0)
		{
					
		$name0=$gene;
		$scafseq=&getwholefasta($scaf, $fasta);
		$/ = "\n";
		if ($strand =~ m/\+\+/)
			{
			$scafseq =~ s/>.*\n//g;
			$scafseq =~ s/>//g;
			$scafseq =~ s/\W*\n//g;
			print RESULTS "NNNnnnNNNnnnNNNnnnNNN\n$scafseq\n";
			}
		elsif ($strand =~ m/\-\-/)
			{
			$scafseq =~ s/>.*\n//g;
			$scafseq =~ s/>//g;
			$scafseq =~ s/\W*\n//g;
			print RESULTS "NNNnnnNNNnnnNNNnnnNNN\n$scafseq\n";
			}
		else
			{
			$rcseqs=&reversecomplement($scafseq);
			$rcseqs =~ s/>.*\n//g;
			$scafseq =~ s/>//g;
			$scafseq =~ s/\W*\n//g;
			print RESULTS "NNNnnnNNNnnnNNNnnnNNN\n$rcseqs\n";
			}


		}
	else
		{
		print RESULTS ">$gene\n";
		$name0=$gene;
		$scafseq=&getwholefasta($scaf, $fasta);
		$/ = "\n";
		if ($strand =~ m/\+\+/)
			{
			$scafseq =~ s/>.*\n//g;
			$scafseq =~ s/>//g;
			$scafseq =~ s/\W*\n//g;
			print RESULTS "$scafseq\n";
			}
		elsif ($strand =~ m/\-\-/)
			{
			$scafseq =~ s/>.*\n//g;
			$scafseq =~ s/>//g;
			$scafseq =~ s/\W*\n//g;
			print RESULTS "$scafseq\n";
			}
		else
			{
			$rcseqs=&reversecomplement($scafseq);
			$rcseqs =~ s/>.*\n//g;
			$scafseq =~ s/>//g;
			$scafseq =~ s/\W*\n//g;
			print RESULTS "$rcseqs\n";
			}

		}
		
	
	}



#this returns the reverse complement of a fasta sequence

sub getwholefasta
{

        my ($sequencename, $fastafile, $wholefastaout);
        ($sequencename)=$_[0];
        ($fastafile)=$_[1];
        ($start)=$_[2];
        ($end)=$_[3];
        $end1=$end-1;
        $start1=$start-1;
        $/ = ">";
        open (FASTAFILE, "$fastafile");
        while ($seqs=<FASTAFILE>) {
	@stuff=split("\n", $seqs);
	$nameofsequence=$stuff[0];
	$nameofsequence =~ s/ .*//;
        if ($nameofsequence eq $sequencename)
                {
		print ".";
		shift(@stuff);
                $wholefastaout=join("", @stuff);
                }
        else
                {
                }
        }
	chomp $wholefastaout;
        return "$wholefastaout";

 $/ = "\n";
}



#this returns the reverse complement of a fasta sequence
sub reversecomplement
{

	my ($seq, $definition, @dnas,  $dna, @sites, @rev_sites, $rcfasta);
	($seq)=$_[0];
	(@dnas)=split ("\n", $seq);
	$definition=$dnas[0];
	shift @dnas;
	$dna=join ("", @dnas);
	$dna =~ s/>//g;
	@sites=split ("", $dna);
	@rev_sites=reverse(@sites);
	foreach $rev_site (@rev_sites)
		{
		if ($rev_site =~ m/A/)
			{
			$rev_site =~ s/A/T/g;
			}
		elsif ($rev_site =~ m/a/)
			{
			$rev_site =~ s/a/T/g;
			}
		elsif ($rev_site =~ m/T/)
			{
			$rev_site =~ s/T/A/g;
			}
		elsif ($rev_site =~ m/t/)
			{
			$rev_site =~ s/t/A/g;
			}
		elsif ($rev_site =~ m/G/)
			{
			$rev_site =~ s/G/C/g;
			}
		elsif ($rev_site =~ m/g/)
			{
			$rev_site =~ s/g/C/g;
			}
		elsif ($rev_site =~ m/C/)
			{
			$rev_site =~ s/C/G/g;
			}
		elsif ($rev_site =~ m/c/)
			{
			$rev_site =~ s/c/G/g;
			}
		else
			{$rev_site = $rev_site;}
		}
	$rev_sites_joined=join ("", @rev_sites);
	$rcfasta= join ("\n", $definition, $rev_sites_joined);

	return "$rcfasta";
	 $/ = "\n";
}

system "perl -pi -e 's/^\n//gi' $blat.fasta";



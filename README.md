# Rotation1

This are all scripts used during my first rotation in the Vicoso Lab

## Part 1
The first part aimed at interaction between interest genes in different species.

All interaction table was downloaded from StringDB, in particular:
 - protein.links.full.v10.5.txt.gz -> which has data for protein interaction for all the genes in all the species 
        available in StringDB
 - protein.aliases.v10.5.txt.gz -> file with the aliases for genes in the above table

To extract only data for S. cerevisiae, C. elegan, mice and humans (along with the aliases) the *spp.sh* sccript was used.
Each number referes to a specie, as details in StringDB documentation.

Used a julia notebook to analyse the interactions in the *Orthologs and Interactions.ipynb*
The notebook can be run with iPython, or iJulia. (if you need any help, contact me)
It's worth noting that if you simply open the notebook in a text editor, the output will be a big pile of
    commands not meant for human eyes. It is possible to read and understand it, but it won't be easy or pretty.

Finally, to check the number of interactions between the interest genes I used the bash script *orths.sh*, which counts
    how many interactions each pair of genes has.

## Part 2
The second part aimed at analysing if the expression of the interest genes was already in an ideal level in the ancestor or 
    if they got to such expression levels after being recruited.

For that we downloaded expression data for embryos of D. melanogaster, B. oleae (only one sample) and B. jarvisi.
After that the data was trimed for quality, and finally assembled so that RNAseq expression data was gathered. Both species
    were assembled using D. melanogaster CDS as reference. To get this the scripts *jarvisi#.sh* were used in numerical order,
    as were the *drosophila#.sh* scripts.

After this steps to get the expression the R scripts to check which D. melanogaster cell cycle better correlates to the stages
    of B. jarvisi and B. oleae embryogenesis. After this the interest genes were analysed (scripts: analysis.R , analyses_relative.R , analysis_extra.R , analysis_relative_extra.R , bootstrap.R , bootstrap_extra.R) to see if their expression changed or not from D. melanogaster to B. jarvisi/oleae. Graphics were produces for all steps.


## Part 3
The third and final part involved finding the location of the interest genes in C. capitata.
For that the *capitata#.sh* scripts were used in numerical order.

The scripts download the data for scaffolds from C.capitata, use BLAT to find the D. melanogaster genes in the 
    C. capitata scaffolds. Use a majority rule to assign each scaffold to a Muller element (D. melanogaster chromosomes 
    used as proxy for the Muller elements). And create a table were each gene has its location in C. cpaitata and in 
    D. melanogaster.

Finally, the R script *locations.R* was used to verify the locations of the interest genes in D. melanogaster and
    C. capitata.

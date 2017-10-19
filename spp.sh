#!/bin/bash

# script to separate spp (yeast, mice, human and worm) from the total protein interactome form String-DB

# zgrep, because it takes so long to extract the file ¯\_(ツ)_/¯

# accession numbers in String-DB: human - 9606 | m. musculus - 10090 | dmel - 7227 | c. elegans - 6239 | s. cerevisiae - 4932

echo "initiating human"
date

grep ^"9606\." protein.links.full.v10.5.txt.gz | awk '($10 != 0) {print $1, $2, $10}' > human_experimental.txt
zgrep ^"9606\." protein.aliases.v10.5.txt.gz > human_aliases.txt

echo "finished human. initiating mouse"
date

grep ^"10090\." protein.links.full.v10.5.txt.gz | awk '($10 != 0) {print $1, $2, $10}' > mouse_experimental.txt
zgrep ^"10090\." protein.aliases.v10.5.txt.gz > mouse_aliases.txt

echo "finished mouse. initiating fly"
date

grep ^"7227\." protein.links.full.v10.5.txt.gz | awk '($10 != 0) {print $1, $2, $10}' > dmel_experimental.txt
zgrep ^"7227\." protein.aliases.v10.5.txt.gz > dmel_aliases.txt

echo "finished fly. initiating c. elegans"
date

grep ^"6239\." protein.links.full.v10.5.txt.gz | awk '($10 != 0) {print $1, $2, $10}' > celegans_experimental.txt
zgrep ^"6239\." protein.aliases.v10.5.txt.gz > celegans_aliases.txt

echo "finished c. elegans. initiating yeast"
date

zgrep ^"4932\." protein.links.full.v10.5.txt.gz | awk '($10 != 0) {print $1, $2, $10}' > yeast_experimental.txt
zgrep ^"4932\." protein.aliases.v10.5.txt.gz > yeast_aliases.txt

echo "finished yeast. bye bye"
date


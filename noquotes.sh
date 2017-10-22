#!/bin/bash

#script to remove quotation marks from files made with julia

sed 's/"//g' yeast_allinteractions1.txt >yeast_allinteraction.txt
sed 's/"//g' celegans_allinteractions1.txt >celegans_allinteraction.txt
sed 's/"//g' mouse_allinteractions1.txt >mouse_allinteraction.txt
sed 's/"//g' human_allinteractions1.txt >human_allinteraction.txt
sed 's/"//g' dmel_allinteractions1.txt >dmel_allinteraction.txt
rm *_allinteractions1.txt


sed 's/"//g' yeast_queryinteractions1.txt >yeast_queryinteraction.txt
sed 's/"//g' celegans_queryinteractions1.txt >celegans_queryinteraction.txt
sed 's/"//g' dmel_queryinteractions1.txt >dmel_queryinteraction.txt
sed 's/"//g' mouse_queryinteractions1.txt >mouse_queryinteraction.txt
sed 's/"//g' human_queryinteractions1.txt >human_queryinteraction.txt
rm *_queryinteractions1.txt

sed 's/"//g' yeast_numbers1.txt >yeast_numbers.txt
sed 's/"//g' celegans_numbers1.txt >celegans_numbers.txt
sed 's/"//g' mouse_numbers1.txt >mouse_numbers.txt
sed 's/"//g' human_numbers1.txt >human_numbers.txt
sed 's/"//g' dmel_numbers1.txt >dmel_numbers.txt

sed 's/"//g' allorthologs_numbers1.txt >allorthologs_numbers.txt

rm *_numbers1.txt

#!/bin/bash

awk '{print $2 "\t" $6}' celegans_queryinteraction.txt | sort | uniq -c >orth_celegans.txt


awk '{print $2 "\t" $6}' yeast_queryinteraction.txt | sort | uniq -c >orth_yeast.txt

awk '{print $2 "\t" $6}' mouse_queryinteraction.txt | sort | uniq -c >orth_mouse.txt

awk '{print $2 "\t" $6}' human_queryinteraction.txt | sort | uniq -c >orth_human.txt

awk '{print $2 "\t" $6}' dmel_queryinteraction.txt | sort | uniq -c >orth_dmel.txt



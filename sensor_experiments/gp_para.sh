#!/bin/bash
 
rm parameters
     counter=1;
 for i in $(seq 4 1 25 );
#do
# for j in $(seq 1 1 10000 );

#do
#for k in $(seq 1 1 1000);
do
  echo '['$i,$counter']' >> parameters
  counter=$[counter+1];
done
#done 
#done

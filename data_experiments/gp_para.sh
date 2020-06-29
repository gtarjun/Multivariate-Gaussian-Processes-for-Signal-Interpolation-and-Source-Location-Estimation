#!/bin/bash
 
rm parameters
     counter=1;
 for i in $(seq 5 5 80 );
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

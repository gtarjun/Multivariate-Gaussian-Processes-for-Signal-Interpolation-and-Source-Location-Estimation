#/bin/bash

LOG=status.log

HOST=$(hostname -s)
NOW=$(date -I)


# export TIME="ET, M(a), M(max), swap, waits, I, O: 
export TIME="%e, %K, %M, %W, %I, %O"

echo "[ $NOW, $HOST ] Starting $1 " >> $LOG

/usr/bin/time -ao time.log matlab -nodesktop -nodisplay -r "params=$1;bayesian_formulation"

echo "[ $NOW, $HOST ] Finished $1" >> $LOG

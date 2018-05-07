#!/bin/sh
SCRIPT="../../test/scripts/submitGridpackCondorJob.py"
MODEL="SMS-N1N1"
JOBS="jobs"

for MNLSP in 400; do
    echo --cards-dir ${JOBS}/${MODEL}${MNLSP} --proxy /tmp/x509up_u31582 --genproductions-dir 
    #python ${SCRIPT} ${MODEL}${MNLSP} --cards-dir ${JOBS}/${MODEL}${MNLSP} --proxy /tmp/x509up_u31582 --genproductions-dir "/home/users/ana/genproductions/"
done

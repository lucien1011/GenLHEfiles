#!/bin/sh
SCRIPT="../../test/scripts/submitGridpackCondorJob.py"
MODEL="SMS-StopStop-bl_mStop-"
JOBS="jobs"
outDir="/afs/cern.ch/work/k/klo/SUSY/RPV/EvtGeneration/gridpacks/"

for MPROD in {800,900,1000}; do
    python ${SCRIPT} ${MODEL}${MPROD} --cards-dir ${JOBS}/${MODEL}${MPROD} --genproductions-dir ${genprodir} --proxy ${vomsdir} --outDir ${outDir} --time 18000 
done

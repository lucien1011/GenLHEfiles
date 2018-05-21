#!/bin/sh
SCRIPT="../../test/scripts/submitGridpackCondorJob.py"
MODEL="SMS-StopStop-bl_mStop-"
JOBS="jobs"
outDir="/afs/cern.ch/work/k/klo/SUSY/RPV/EvtGeneration/gridpacks/"

for MPROD in {600,700,800,900,1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000}; do
    python ${SCRIPT} ${MODEL}${MPROD} --cards-dir ${JOBS}/${MODEL}${MPROD} --genproductions-dir ${genprodir} --proxy ${vomsdir} --outDir ${outDir} --time 259200 
done

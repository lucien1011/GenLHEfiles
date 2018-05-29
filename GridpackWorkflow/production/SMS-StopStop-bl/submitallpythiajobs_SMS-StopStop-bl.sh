#!/bin/sh
SCRIPT="../../test/scripts/submitPythiaCondorJob.py"
MODEL="SMS-StopStop-bl_mStop-"
JOBS="jobs"

baseOutDir=/eos/cms/store/user/klo/SUSY/RAWSIM/SMS-StopStop-bl/
for MPROD in {600,700,800,900,1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,}; do
    if [ ! -d "${baseOutDir}${MODEL}${MPROD}" ]; then
        mkdir ${baseOutDir}${MODEL}${MPROD}
    fi
    python ${SCRIPT} ${MODEL}${MPROD} --in-dir /eos/cms/store/user/klo/SUSY/LHE/SMS-StopStop-bl/${MODEL}${MPROD}/ --slha ${JOBS}/${MODEL}${MPROD}/${MODEL}${MPROD}.slha --qcut-range 60 80 --outDir ${baseOutDir}${MODEL}${MPROD} --time 36000
done

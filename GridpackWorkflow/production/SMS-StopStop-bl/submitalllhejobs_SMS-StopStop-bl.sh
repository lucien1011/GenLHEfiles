#!/bin/sh
SCRIPT="../../test/scripts/submitLHECondorJob.py"
MODEL="SMS-StopStop-bl_mStop-"

#for MPROD in {600,700,800,900,1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000}; do
for MPROD in {600,700,800,900,1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,}; do
    python ${SCRIPT} ${MODEL}${MPROD} --in-file /afs/cern.ch/work/k/klo/SUSY/RPV/EvtGeneration/gridpacks/${MODEL}${MPROD}_tarball.tar.xz  --proxy ${vomsdir} --nevents 20000 --njobs 5 --time 259200 --outDir /eos/cms/store/user/klo/SUSY/LHE/SMS-StopStop-bl/ --genproductions-dir /afs/cern.ch/work/k/klo/SUSY/RPV/EvtGeneration/genproductions/
done

#!/bin/sh
JOBS="jobs"
TEMP="templatecards"
PROC="SMS-N1N1"
PART="_N1"

### Create cards and SLHAs for all mass points

for MNLSP in 400; do
    MODEL=${PROC}${PART}${MNLSP}
    mkdir -p "${JOBS}/${MODEL}"
    cp ${TEMP}/${PROC}_run_card.dat "${JOBS}/${MODEL}/${MODEL}_run_card.dat"
    sed "s/%MNLSP%/${MNLSP}/g" ${TEMP}/${PROC}_proc_card.dat > "${JOBS}/${MODEL}/${MODEL}_proc_card.dat"
    sed "s/%MNLSP%/${MNLSP}/g" ${TEMP}/${PROC}_customizecards.dat > "${JOBS}/${MODEL}/${MODEL}_customizecards.dat"
    sed "s/%MNLSP%/${MNLSP}/g" ${TEMP}/${PROC}.slha > ${JOBS}/${MODEL}/${MODEL}.slha
done

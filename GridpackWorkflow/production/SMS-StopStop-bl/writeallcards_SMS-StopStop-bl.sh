#!/bin/sh
JOBS="jobs"
TEMP="templatecards"
PROC="SMS-StopStop-bl"
PART="_mStop-"

### Create cards and SLHAs for all mass points

for MPROD in {600,700,800,900,1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000}; do
    MODEL=${PROC}${PART}${MPROD}
    mkdir -p "${JOBS}/${MODEL}"
    cp ${TEMP}/${PROC}_run_card.dat "${JOBS}/${MODEL}/${MODEL}_run_card.dat"
    sed "s/%MPROD%/${MPROD}/g" ${TEMP}/${PROC}_proc_card.dat > "${JOBS}/${MODEL}/${MODEL}_proc_card.dat"
    sed "s/%MPROD%/${MPROD}/g" ${TEMP}/${PROC}_customizecards.dat > "${JOBS}/${MODEL}/${MODEL}_customizecards.dat"
    sed "s/%MPROD%/${MPROD}/g" ${TEMP}/${PROC}.slha > ${JOBS}/${MODEL}/${MODEL}.slha
done

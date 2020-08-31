#!/bin/bash
set -e
source /qserv/stack/loadLSST.bash
setup -t qserv-dev qserv_distrib
WORKER=$(hostname -s)
DATABASE=wise_01
TABLE=allwise_p3as_mep
INPUT=/datasets/gapon/${DATABASE}/qserv-ncsa-wise/${TABLE}
OUTPUT=/qserv/work/${DATABASE}/${TABLE}
mkdir -p ${OUTPUT}
cd ${OUTPUT}
mkdir -p allocate_chunks
mkdir -p logs
rm -f allocate_chunks/*
for f in $(ls ${INPUT}/worker_input/${WORKER}); do \
    STREAM=${f:0:-4}; \
    TRANSACTION_ID=$(cat transactions/${STREAM}); \
    python ${INPUT}/worker_scripts/allocate_chunks.py ${TRANSACTION_ID} chunks/${STREAM} > allocate_chunks/${STREAM}.json 2>logs/allocate_chunks.${STREAM}.log; \
done

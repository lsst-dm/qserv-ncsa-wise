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
mkdir -p chunks
mkdir -p logs
rm -f chunks/*
for f in $(ls ${INPUT}/worker_input/${WORKER}); do \
    STREAM=${f:0:-4}; \
    mkdir -p chunks/${STREAM}; \
    sph-partition --out.dir=chunks/${STREAM} \
        --in=${INPUT}/worker_input/${WORKER}/${f} \
        --config-file=${INPUT}/partition.cfg \
        >& logs/partition.${STREAM}.log; \
done

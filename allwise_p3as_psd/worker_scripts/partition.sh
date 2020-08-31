#!/bin/bash
set -e
source /qserv/stack/loadLSST.bash
setup -t qserv-dev qserv_distrib
WORKER=$(hostname -s)
DATABASE=wise_01
TABLE=allwise_p3as_psd
INPUT=/datasets/gapon/${DATABASE}/qserv-ncsa-wise/${TABLE}
OUTPUT=/qserv/work/${DATABASE}/${TABLE}
mkdir -p ${OUTPUT}
cd ${OUTPUT}
rm -rf ./*
mkdir chunks
mkdir logs
for f in $(cat ${INPUT}/worker_input/${WORKER}); do \
    STREAM=${f:0:-4}; \
    sph-partition --out.dir=chunks/${STREAM} \
        --in=${INPUT}/input/${f} \
        --config-file=${INPUT}/partition.cfg \
        >& logs/partition.${STREAM}.log; \
done

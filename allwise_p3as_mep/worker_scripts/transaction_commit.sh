#!/bin/bash
set -e
source /qserv/stack/loadLSST.bash
setup -t qserv-dev qserv_distrib
WORKER=$(hostname -s)
DATABASE=wise_01
TABLE=allwise_p3as_mep
INPUT=/datasets/gapon/${DATABASE}/qserv-ncsa-wise/${TABLE}
OUTPUT=/qserv/work/${DATABASE}/${TABLE}
cd ${OUTPUT}
mkdir -p logs
for f in $(ls ${INPUT}/worker_input/${WORKER}); do \
    STREAM=${f:0:-4}; \
    python ${INPUT}/worker_scripts/transaction_commit.py $(cat transactions/${STREAM}) >& logs/transaction_commit.${STREAM}.log; \
done

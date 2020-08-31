#!/bin/bash
set -e
source /qserv/stack/loadLSST.bash
setup -t qserv-dev qserv_distrib
export LD_LIBRARY_PATH=/qserv/lib:${LD_LIBRARY_PATH}
WORKER=$(hostname -s)
DATABASE=wise_01
TABLE=allwise_p3as_psd
INPUT=/datasets/gapon/${DATABASE}/qserv-ncsa-wise/${TABLE}
OUTPUT=/qserv/work/${DATABASE}/${TABLE}
cd ${OUTPUT}
for f in $(cat ${INPUT}/worker_input/${WORKER}); do \
    STREAM=${f:0:-4}; \
    TRANSACTION_ID=$(cat transactions/${STREAM}); \
    /qserv/bin/qserv-replica-file-ingest FILE-LIST-TRANS ${TRANSACTION_ID} ${TABLE} P allocate_chunks/${STREAM}.json --auth-key=*** --verbose >& logs/ingest.${STREAM}.log& \
done
wait

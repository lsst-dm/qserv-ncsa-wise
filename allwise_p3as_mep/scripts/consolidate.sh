#!/bin/bash
set -e
WORKER="$1"
if [ -z "${WORKER}" ]; then
  >&2 echo "Usage: <worker>"
  exit 1
fi
cd /datasets/gapon/wise_01/qserv-ncsa-wise/allwise_p3as_mep/worker_input
mkdir -p ${WORKER}
rm -f ${WORKER}/*
for s in $(ls ../worker_streams/${WORKER}); do
  for f in $(cat ../worker_streams/${WORKER}/${s}); do
    cat ../input/${f} >> ${WORKER}/${s}.tsv
  done&
done
wait

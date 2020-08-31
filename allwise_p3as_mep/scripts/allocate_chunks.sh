#!/bin/sh
set -e
. /datasets/gapon/wise_01/qserv-ncsa-wise/allwise_p3as_mep/scripts/env.sh
$CONTAINER_CMD /datasets/gapon/wise_01/qserv-ncsa-wise/allwise_p3as_mep/worker_scripts/allocate_chunks.sh

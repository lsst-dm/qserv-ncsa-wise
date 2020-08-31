#!/bin/bash
set -e
. /datasets/gapon/wise_01/qserv-ncsa-wise/allwise_p3as_psd/scripts/env.sh
$CONTAINER_CMD /datasets/gapon/wise_01/qserv-ncsa-wise/allwise_p3as_psd/worker_scripts/transaction_commit.sh

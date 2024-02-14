#!/bin/bash

DOMAIN_PATH="/u01/domains/base_domain"

export USER_MEM_ARGS="-Djava.security.egd=file:/dev/./urandom -Xms256m -Xmx512m -XX:CompileThreshold=8000 -XX:PermSize=128m -XX:MaxPermSize=256m"

source /u01/middleware1036/wlserver_10.3/server/bin/setWLSEnv.sh

function startWLS() {
    $DOMAIN_PATH/bin/startWebLogic.sh
}

function stopWLS() {
    echo "SIGTERM Detected, stopping Weblogic Server 10.3.6"
    $DOMAIN_PATH/bin/stopWebLogic.sh
    exit 0
}

trap stopWLS SIGTERM
startWLS
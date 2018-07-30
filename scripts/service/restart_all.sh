#!/bin/bash
SCRIPT_PATH=$(cd `dirname $0` && pwd)
source /etc/profile
$SCRIPT_PATH/stop_all.sh
$SCRIPT_PATH/start_all.sh

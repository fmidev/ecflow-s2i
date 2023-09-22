set -uex

mkdir -p $ECF_HOME && cd $ECF_HOME

# this script is handy but overrides ECF_CHECK env variable        
# ecflow_start.sh -p $ECF_PORT

nohup ecflow_server > $ECF_HOME/ecflow.log 2>&1 < /dev/null &
sleep 5 # wait for server start
ecflow_client --restart
create-defs.sh 
load-defs.sh

set +u

for v in "ECF_RESTAPI_HOST" "ECF_RESTAPI_PORT" "ECF_LOGHOST" "ECF_LOGPORT" "FMI_ENV"; do
  eval test "x" != x\$$v && eval ecflow_client --alter add variable "$v" "\$$v" /
done

sleep infinity

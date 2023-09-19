set -ex

if [ -n "$ECF_DISABLE_SUITE_LOAD" ]; then
  exit 0
fi

if [ -z "$ECF_BASE" ] ; then
  ECF_BASE=/usr/share/ecflow/suites
fi

for def in $(find $ECF_BASE -name "*def"); do
  /usr/ecflow5/bin/ecflow_client --load $def
done

for s in $(ecflow_client --suites); do
  ecflow_client --begin $s
done

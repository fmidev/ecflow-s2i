set -ex

if [ -n "$ECF_DISABLE_SUITE_LOAD" ]; then
  exit 0
fi

if [ -z "$ECF_BASE" ] ; then
  ECF_BASE=/usr/share/ecflow/suites
fi

num_suites=0
for py in $(find $ECF_BASE -name "*py"); do

  dir=$(dirname $py)
  export ECF_FILES=$dir/scripts
  cd $dir
  python3 $py
  num_suites=$(expr $num_suites + 1)

done

echo "found $num_suites suites"

if [ $num_suites -eq 0 ]; then
  exit 1
fi

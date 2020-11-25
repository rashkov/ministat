#!/bin/bash
set -euo pipefail

testdir="$(dirname $(readlink -f $0))"
gendir="$testdir/data_gen"
datadir="$testdir/input_data"

cd "$gendir" && make >/dev/null

if [ -d "$datadir" ]
then
  printf "Delete existing data in $datadir? [y/n] "
  read resp
  if [ $resp == "y" ]
  then
    rm -r "$datadir"
  else
    exit
  fi
fi
mkdir -p "${datadir}"

for i in {7..27}
do
	count=$((1<<${i}))
	filepath=${datadir}/${count}.txt
	echo "Generating ${count} rows: ${filepath}"
	./gen ${count} 10000000 "${filepath}"
done

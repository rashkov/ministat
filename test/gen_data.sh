#!/bin/bash
set -euxo pipefail

testdir="$(dirname $(readlink -f $0))"
gendir="$testdir/data_gen"
datadir="$testdir/input_data"

cd "$gendir" && make

mkdir -p "${datadir}"

for i in {7..27}
do
	count=$((1<<${i}))
	filepath=${datadir}/${count}.txt
	echo "Generating ${count} rows: ${filepath}"
	./gen ${count} 10000000 "${filepath}"
done

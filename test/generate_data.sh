#!/bin/bash

testdir=$(dirname $(readlink -f $0))
outdir="$testdir/out"
datadir="$outdir/data"

mkdir -p "${datadir}"

for i in {7..27}
do
	count=$((1<<${i}))
	filepath=${datadir}/${count}.txt
	echo "Generating ${count} rows: ${filepath}"
	./gen ${count} 10000000 "${filepath}"
done

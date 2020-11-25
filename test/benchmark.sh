#!/usr/bin/env bash

testdir=$(dirname $(readlink -f $0))
outdir="$testdir/out"
datadir="$outdir/data"
chartsdir="$outdir/charts"
tablesdir="$outdir/tables"

mkdir -p "${chartsdir}"
mkdir -p "${tablesdir}"

for file in "${datadir}"/*; do
	[ -e "$file" ] || continue
	echo $file
	testcase=$(basename $file .txt)
	echo "Running benchmark with $testcase datapoints"
	"$testdir"/../ministat -qv "$file" > "$tablesdir/${testcase}.txt"
done

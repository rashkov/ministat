#!/usr/bin/env bash

testdir=$(dirname $(readlink -f $0))
exesdir="$testdir/executables"
outdir="$testdir/out"
datadir="$outdir/data"
chartsdir="$outdir/charts"
tablesdir="$outdir/tables"

mkdir -p "${chartsdir}"
mkdir -p "${tablesdir}"

for exe in "${exesdir}"/*; do
  echo exe $exe
  mkdir -p "$tablesdir/$exe"
  for file in "${datadir}"/*; do
    [ -e "$file" ] || continue
    testcase=$(basename $file .txt)
    exename=$(basename $exe)
    echo "$exename / $testcase datapoints"
    $exe -qv "$file" > "$tablesdir/$exename/${testcase}.txt"
  done
done

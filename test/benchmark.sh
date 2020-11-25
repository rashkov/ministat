#!/usr/bin/env bash

testdir=$(dirname $(readlink -f $0))
exesdir="$testdir/executables"
datadir="$testdir/input_data"
outdir="$testdir/out"
chartsdir="$outdir/charts"
tablesdir="$outdir/tables"

if [ -d "$tablesdir" ]
then
  rm -r "$tablesdir"
fi
mkdir -p "$chartsdir"
mkdir -p "$tablesdir"

for exe in "$exesdir"/*; do
  for file in "$datadir"/*; do
    [ -e "$file" ] || continue
    testcase=$(basename $file .txt)
    exename=$(basename $exe)
    echo "Running: $exename / $testcase datapoints"
    mkdir -p "$tablesdir/$exename"
    $exe -qv "$file" > "$tablesdir/$exename/$testcase.txt"

    if [ $? -ne 0 ]
    then
      printf "\n\nExiting: Error while running $exe\n"
      exit 1
    fi
  done
done

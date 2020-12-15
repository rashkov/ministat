#!/usr/bin/env bash

set -euo pipefail

testdir=$(dirname $(readlink -f $0))
exesdir="$testdir/executables"
datadir="$testdir/input_data"
outdir="$testdir/out"
chartsdir="$outdir/charts"
tablesdir="$outdir/tables"

(source "$testdir/gen_data.sh")

if [ -d "$tablesdir" ]
then
  rm -r "$tablesdir"
fi
mkdir -p "$tablesdir"

if [ -d "$chartsdir" ]
then
  rm -r "$chartsdir"
fi
mkdir -p "$chartsdir"

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
  paste -d$'\n' "$tablesdir/$exename"/*.txt |uniq |sort -nk1 > "$tablesdir/$exename.tsv"
done


filepaths=( "$tablesdir"/*.tsv )
filenames=( )
for i in "${!filepaths[@]}";
do
  filenames[i]=$(basename ${filepaths[i]})
done

printf "\nData tables written to: $tablesdir\n\n"

# Function for calling out to gnuplot
create_plots () {
  colNum="$1"
  colName="$2"
  gnuplot -p <<- EOF
    set term svg
    set output "$chartsdir/$colName.svg"

    set datafile separator '\t'
    set ylabel "log($colName)" noenhanced # label for the Y axis
    set xlabel 'log(num_points)' noenhanced # label for the X axis
    set logscale x 2
    set logscale y 2

    filepaths = "${filepaths[@]}"
    filenames = "${filenames[@]}"
    plot for [i=1:words(filepaths)] word(filepaths,i) using 1:$colNum with lines smooth unique title word(filenames,i) noenhanced
EOF
}

# Read in the column names
IFS=$'\t' read -r -a columnsArray < <(head -n 1  "${filepaths[0]}")

# Display column choices and read in user response
echo "Which benchmarks would you like to plot?"
n=1
for col in "${columnsArray[@]:1}";
do
  echo "  $n: $col";
  n=$((n+1))
done
echo "  $n: All of the above";
printf "Please choose one of the above [All] "
read resp

# Parse user response and create plots
if [[ "$resp" == "" || "$resp" == $n ]]; then
  colNum=1
  for colName in "${columnsArray[@]:1}";
  do
    colNum=$((colNum+1))
    create_plots "$colNum" "$colName"
  done
  printf "\nCharts written to: $chartsdir"
elif [[ "$resp" -gt 0 && "$resp" -lt $n ]]; then
  colNum="$resp"
  colName=${columnsArray[$colNum]}
  create_plots "$colNum" "$colName"
  printf "\nCharts written to: $chartsdir\n"
fi

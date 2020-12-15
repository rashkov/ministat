#!/bin/bash
set -euo pipefail

testdir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)
gendir="$testdir/data_gen"
datadir="$testdir/input_data"

cd "$gendir" && make >/dev/null

# Check if data dir is already populated with files
if [[ -d "$datadir" && $(find $datadir -type f | wc -l) -gt 0 ]]; then
  exit;
  #printf "Delete existing data in $datadir? [y/n] "
  #read resp
  #if [ $resp == "y" ]
  #then
  #  rm -r "$datadir"
  #else
  #  exit
  #fi
fi
mkdir -p "${datadir}"

for i in {7..27}
do
	count=$((1<<${i}))
	filepath=${datadir}/${count}.txt
	echo "Generating ${count} rows: ${filepath}"
	./gen ${count} 10000000 "${filepath}"
done

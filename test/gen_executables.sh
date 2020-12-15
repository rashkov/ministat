#!/usr/bin/env bash

BRANCHES=(
  an_qsort
  open_read_write_close
  timing
)

testdir=$(dirname $(readlink -f $0))
ministatdir="$testdir/.."
exesdir="$testdir/executables"

if [ -n "$(git status --untracked-files=no --porcelain)" ]; then 
  # Uncommitted changes in tracked files
  echo "Please commit all git changes before running this script. See output of 'git status'."
  exit
fi

if [ -d "$exesdir" ]
then
  printf "Delete existing executables in $exesdir? [y/n] "
  read resp
  if [ $resp == "y" ]
  then
    rm -r "$exesdir"
  else
    exit
  fi
fi
mkdir -p "$exesdir"

current=$(git branch --show-current)

for branch in ${BRANCHES[*]}
do
  echo ""
  echo Building $branch
  cd "$ministatdir" && \
  git checkout "$branch" && \
  make clean && \
  make && \
  cp ministat "$exesdir/ministat_$branch"
done

cd $testdir
git checkout $current

printf "\n\n\n"
echo "Generated the following executables:"
for exe in "$exesdir/"*; do
  printf "\t$exe\n"
done

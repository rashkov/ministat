#!/usr/bin/env bash

BRANCHES=(
  an_qsort
  open_read_write_close
  timing
)

testdir=$(dirname $(readlink -f $0))
ministatdir="$testdir/.."
exesdir="$testdir/executables"
mkdir -p "${exesdir}"

current=$(git branch --show-current)

for branch in ${BRANCHES[*]}
do
  echo Building $branch
  cd "$ministatdir" && \
  git checkout "$branch" && \
  make clean && \
  make && \
  cp ministat "$exesdir/ministat_$branch"
done

git checkout $current

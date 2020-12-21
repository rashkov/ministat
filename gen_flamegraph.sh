perf record -F 99 -g ./ministat -q ./test/input_data/134217728.txt ./test/input_data/134217728.txt
perf script | ./stackcollapse-perf.pl > out.perf-folded
./flamegraph.pl out.perf-folded > perf-ministat.svg
echo "Flamegraph written to ./perf-ministat.svg"

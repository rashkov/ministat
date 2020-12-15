Add executables to the executables sub-directory within this test folder.

Then run:
  ./benchmark.sh

If that doesn't work:
  bash ./benchmark.sh

This will create a folder named input_data and populate it with files of varying sizes, each one filled with a single column of random numbers less than or equal to 10000000. See file gen_data.sh for how this is done.

Then it will run each executable with the -qv flags against each of those files. The output of each of these runs is saved to the out/tables folder.

Then it uses files in out/tables to generate plots using gnuplot. Those plots are saved to the out/charts folder.

Finally, use can use scp to copy the results back to your home machine to view the plots.

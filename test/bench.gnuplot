set datafile separator '\t'

#set key autotitle columnhead # use the first line as title
set ylabel "time elapsed (us)" # label for the Y axis
set xlabel 'log2(filesize)' # label for the X axis
#set autoscale
#set logscale x 2

plot "minibench.tsv" using 1:2 with lines smooth unique

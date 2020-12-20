# ministat
A small tool to do the statistics legwork on benchmarks etc.

# Perf 
## Flamegraph
Click on image below to get an interactive version
![Flamegraph](https://raw.githubusercontent.com/rashkov/ministat/master/perf-ministat.svg)

# Goal
Optimize the AddPoint function within ministat.c and make it so the realloc does not use calloc or memcpy.

## Problems:
The current ministat way of adding additional space was inefficient as it makes large copies of the already existing array and doubling it. Memcpy is very taxing on the program so changing it to a realloc will resolve some of this. I had difficulty understanding how to change the calloc and memcpy into a simple realloc. To resolve it I read the man pages and did more examples using all three functions to understand how they truly worked.


## Results
There was a slight improvement in the code when changing.

### Before


### After

---

## Build & Install

There should be no dependencies besides the standard libraries and a functional tool-chain.

	$ cd ministat/
	$ make
	$ make PREFIX=/usr install
	install -m 0755 ministat  /usr/bin/ministat

## Usage
The FreeBSD man page is very relevant, pursue it [here](http://www.freebsd.org/cgi/man.cgi?ministat).

	Usage: ministat [-C column] [-c confidence] [-d delimiter(s)] [-ns] [-w width] [file [file ...]]
		confidence = {80%, 90%, 95%, 98%, 99%, 99.5%}
		-C : column number to extract (starts and defaults to 1)
		-d : delimiter(s) string, default to " \t"
		-n : print summary statistics only, no graph/test
		-q : print summary statistics and test only, no graph
		-s : print avg/median/stddev bars on separate lines
		-w : width of graph/test output (default 74 or terminal width)

## Example
From the FreeBSD [man page](http://www.freebsd.org/cgi/man.cgi?ministat)

	$ cat << EOF > iguana
	50
	200
	150
	400
	750
	400
	150
	EOF

	$ cat << EOF > chameleon
	150
	400
	720	
	500
	930
	EOF

	$ ministat -s -w 60 iguana chameleon
	x iguana
	+ chameleon
	+------------------------------------------------------------+
	|x      *  x	     *	       +	   + x	            +|
	| |________M______A_______________|			     |
	| 	      |________________M__A___________________|      |
	+------------------------------------------------------------+
	    N	  Min	     Max     Median	   Avg	     Stddev
	x   7	   50	     750	200	   300	  238.04761
	+   5	  150	     930	500	   540	  299.08193
	No difference proven at 95.0% confidence

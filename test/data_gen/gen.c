#include <stdio.h>
#include <stdlib.h>
#include <float.h>

int
main(int argc, char **argv){
	if(argc < 3){
		printf("Usage: ./gen <count> <max>\nGenerate <count> integers up to <max> maximum, and write to newline separated file <file>:\n");
		return -1;
	}
	int count = atoi(argv[1]);
	int max = atoi(argv[2]);
	char * filename = argv[3];
	
	if(max < 0 || max > RAND_MAX){
		printf("<max> must be less than %d\n", RAND_MAX);
		return -1;
	}

	FILE * outfile = fopen(filename, "w");
	while(count-- > 0){
		fprintf(outfile, "%d\n", rand() % max);
	}
	fclose(outfile);
}

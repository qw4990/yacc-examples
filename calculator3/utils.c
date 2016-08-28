#include "utils.h"

void fatal(char *s) {
	fprintf(stderr, "[Fatal]: %s\n", s);
	exit(1);
}

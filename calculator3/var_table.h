#include "utils.h"

typedef struct Variable {
	char *name;
	double value;
	struct Variable *next;
}Var;

Var *Lookup(char *name);

Var *Create(char *name, double value);


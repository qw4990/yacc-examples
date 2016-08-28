#include "utils.h"

typedef double (*UnaryFunc)(double);

typedef struct Variable {
	char *name;
	double value;
	UnaryFunc unaryFunc;
	struct Variable *next;
}Var;

Var *Lookup(char *name);

Var *Create(char *name, double value);

void AddUnaryFunc(char *name, UnaryFunc fp);

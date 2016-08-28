#include "var_table.h"

const int HASH_LIMIT = 10000;
const int HASH_SEED = 1331;

Var *first[HASH_LIMIT];

// hash hashes str to a number in [0, HASH_LIMIT).
int hash(char *str) {
	int result = 0;
	for (int i=0; i < strlen(str); i++) {
		result = result * HASH_SEED + str[i];
		result %= HASH_LIMIT;
	}
	return result;
}

// Lookup returns the variable identified by name;
// return NULL if not found.
Var *Lookup(char *name) {
	int index = hash(name);
	Var *p = first[index];
	while (p != NULL) {
		if (strcmp(p->name, name) == 0) return p;
		p = p->next;
	}
	return NULL;
}

// Create creates a variable in the table.
Var *Create(char *name, double value) {
	int index = hash(name);
	Var *p = (Var *)malloc(sizeof(Var));
	p->name = strdup(name);
	p->value = value;
	p->next = first[index];
	first[index] = p;
	return p;
}


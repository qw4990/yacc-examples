%{
#include "utils.h"

int yyerror(char *s) {
	fatal(s);
	return 0;
}

int yylex();
%}

%union {
	double number;
}

%token <number> NUM

%type <number> expr

%left '+' '-'
%left '*' '/'
%left '^'

%%

expr_list:	expr_list expr ';'	{ printf("= %f\n", $2); }
	|	/* null */
	;

expr:	NUM				{ $$ = $1; }
	|	expr '+' expr	{ $$ = $1 + $3; }
	|	expr '-' expr	{ $$ = $1 - $3; }
	|	expr '*' expr	{ $$ = $1 * $3; }
	|	expr '/' expr	{ 
							if ($3 == 0) fatal("divide by zero.");
							$$ = $1 / $3; 
						}
	|	'(' expr ')'	{ $$ = $2; }
	|	'-' expr		{ $$ = -$2; }
	|	expr '^' expr	{ $$ = pow($1, $3); }
	;

%%

int main() {
	yyparse();
	return 0;
}

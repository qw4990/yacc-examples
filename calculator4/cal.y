%{
#include "utils.h"
#include "var_table.h"

int yyerror(char *s) {
	fatal(s);
	return 0;
}

int yylex();
%}

%union {
	double number;
	Var *variable;
}

%token <number> NUM
%token <variable> VAR

%type <number> expr

%left '+' '-'
%left '*' '/'
%left '^'

%%

stat_list:	stat_list stat ';'
	|
	;

stat:	expr	{ printf("= %f\n", $1); }
	|	assign
	;

assign:	VAR '=' expr	{ $1->value = $3; }
	;

expr:	NUM					{ $$ = $1; }
	|	VAR					{ $$ = $1->value; }
	|	VAR '(' expr ')'	{ $$ = $1->unaryFunc($3); }
	|	expr '+' expr		{ $$ = $1 + $3; }
	|	expr '-' expr		{ $$ = $1 - $3; }
	|	expr '*' expr		{ $$ = $1 * $3; }
	|	expr '/' expr		{	 
								if ($3 == 0) fatal("divide by zero.");
								$$ = $1 / $3; 
							}
	|	'(' expr ')'		{ $$ = $2; }
	|	'-' expr			{ $$ = -$2; }
	|	expr '^' expr		{ $$ = pow($1, $3); }
	;

%%

int main() {
	AddUnaryFunc("sqrt", sqrt);
	AddUnaryFunc("log", log);
	AddUnaryFunc("exp", exp);

	yyparse();
	return 0;
}

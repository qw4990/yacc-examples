%{
#include "utils.h"
#include "var_table.h"

#include "y.tab.h"

int yywrap() {
	return 0;
}
%}

%%

[a-zA-Z]+			{
						Var *var = Lookup(yytext);
						if (var == NULL) var = Create(yytext, 0);
						yylval.variable = var;
						return VAR;
					}
[0-9]+(\.[0-9]+)?	{ yylval.number = atof(yytext); return NUM; }
[ \t\n\r]			;	// ignore space charaters
[;*/^)(=+-]			{ return yytext[0]; }

%%

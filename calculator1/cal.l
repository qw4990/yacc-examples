%{
#include "utils.h"
#include "y.tab.h"

int yywrap() {
	return 0;
}
%}

%%

[0-9]+(\.[0-9]+)?	{ yylval.number = atof(yytext); return NUM; }
[ \t\n\r]			;	// ignore space charaters
[;*/+-]				{ return yytext[0]; }

%%

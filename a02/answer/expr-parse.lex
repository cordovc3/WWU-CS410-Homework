%{
#include "expr-parse-defs.h"
#include "expr-parse.tab.h"
#include <stdlib.h>
int yyerror (const char *s) {
   fprintf (stderr, "%s\n", s);
   return 0;
 }


%}
%%
\+	{ yylval.sval = strdup(yytext); return PLUS; }
\*	{ yylval.sval = strdup(yytext); return TIMES; }
\(	{ yylval.sval = strdup(yytext); return LPAREN; }
\)	{ yylval.sval = strdup(yytext); return RPAREN; }
[ \t\n]  /* ignore whitespace */
[a-zA-Z_][0-9a-zA-Z_]*       { yylval.sval = strdup(yytext); return ID; }
.	{ return yyerror("syntax error\n"); }
%%

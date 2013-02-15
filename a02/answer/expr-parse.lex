%{
#include "expr-parse.tab.h"
#include "expr-parse-defs.h"
#include <stdlib.h>
int yyerror (const char *s) {
   fprintf (stderr, "%s\n", s);
   return 0;
 }


%}
%%
\+	{ return PLUS; }
\*	{ return TIMES; }
\(	{return LPAREN; }
\)	{return RPAREN; }
[ \t\n]  /* ignore whitespace */
.       { yylval.sval = yytext; return ID; }
%%

%{
/*WWU CS410 HW2 Q5
    Josh Wisdom
    Kyle Coffin
    Charles Cordova
    Nicholas Beichley */

#include "expr-parse-defs.h"
#include "expr-parse.tab.h"
#include <stdlib.h>
int yyerror (const char *s) {
   fprintf (stderr, "%s\n", s);
   return 0;
 }


%}
%%
\+	{ return PLUS; }
\*	{ return TIMES; }
\(	{ return LPAREN; }
\)	{ return RPAREN; }
[ \t\n]  /* ignore whitespace */
[a-zA-Z_][0-9a-zA-Z_]*       { yylval.sval = strdup(yytext); return ID; }
.	{ return yyerror("syntax error"); } /* anything else should be error */
%%

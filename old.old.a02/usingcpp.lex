%{
/* example that illustrates using C++ code and flex/bison */
using namespace std;
#include "usingcpp-defs.h"
#include "usingcpp.tab.h"
#include <cstring>
#include <stdio.h>
 using namespace std;
int yyerror (const char *s) {
   fprintf (stderr, "%s\n", s);
   return 0;
 }

%}

%%
[a-z]                  { yylval.sval = strdup(yytext); return NAME; }
[ \t\n]                ;
.                      return yytext[0];
%%


%{
#include <stdio.h>
%}


%%
[a-zA-Z_][a-zA-Z0-9_]* { printf("ID %s\n", yytext); }
"+"                    { printf("PLUS %s\n", yytext); }
"*"                    { printf("TIMES %s\n", yytext); }
"("                    { printf("LPAREN %s\n", yytext); }
")"                    { printf("RPAREN %s\n", yytext); }
\n
" "
\t
.                      { return -1; }
%%

int main () {
  int token;
  while ((token = yylex())) {
    switch (token) {
      default: printf("Error: %s not recognized\n", yytext);
    }
  }
  exit(0);
}

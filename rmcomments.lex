%{
#include <stdio.h>
#define SINGLELINE 256
#define MULTILINE 257
%}

/* regexp definitions */
num [0-9]+

%%

\"(.|\n)*\"	{return -1;}
\/\/.*		{return SINGLELINE; }
\/\*(.|\n)*\*\/	{return MULTILINE; }
[.\n]		{ return -1; }

%%

int main () {
  int token; int i;
  while ((token = yylex())) {
    switch (token) {
      case SINGLELINE: 
      	for(i = 0; i <= (int) yyleng; i++) {
      		printf(" ");
      	}
      	break;
      case MULTILINE:
      	for(i = 0; i<= (int) yyleng; i++) {
      		if(yytext[i] == '\n') {printf("\n");}
      		else {printf(" ");}
      	}
      	break;
      default: printf("%s", yytext);
    }
  }
  exit(0);
}

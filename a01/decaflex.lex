%{
#include <stdio.h>
#define UNTERM_S 100
%}  

/* regexp definitions */

%%


''		{fprintf(stderr, "Error: empty character");
			exit(1);
		}
'''		{fprintf(stderr, "Error: unescaped ' character");
			exit(1);
		}
'[^\\].'	{fprintf(stderr, "Error: char const length is greater than one");
			exit(1);
		}
\"\"		{fprintf(stderr, "Error: empty string");
			exit(1);
		}
'\\'		{fprintf(stderr, "Error: unescaped character");
			exit(1);
		}
\"\"\"		{fprintf(stderr, "Error: unterminated string constant");
			exit(1);
		}
\"\\[^tnvfrab\"]?\"	{fprintf(stderr, "Error: invalid escape character");
				exit(1);
			}
\"\n\"		{fprintf(stderr, "Error: newline mid string literal");
			exit(1);
		}



"&&"		{printf("T_AND %s\n", yytext);}
"="		{printf("T_ASSIGN %s\n", yytext);}
"bool"		{printf(" T_BOOL %s\n", yytext);}
"break"		{printf("T_BREAK %s\n", yytext);}
"class" 	{printf("T_CLASS %s\n", yytext);}
"//".*\n	{int i;
		printf("T_COMMENT ");
			for(i=0; i< (int) yyleng - 1; i++) {
				printf("%c", yytext[i]);
				}
			printf("\\n\n");
		}	
","		{printf("T_COMMA %s", yytext);}
"continue"	{printf("T_CONTINUE %s\n", yytext);}
"/"		{printf("T_DIV %s\n", yytext);}
"."		{printf("T_DOT %s\n", yytext);}
"else"		{printf("T_ELSE %s\n", yytext);}
"=="		{printf("T_EQ %s\n", yytext);}
"extends"	{printf("T_EXTENDS %s\n", yytext);}
"extern"	{printf("T_EXTERN %s\n", yytext);}
"false"		{printf("T_FALSE %s\n", yytext);}
"for"		{printf("T_FOR %s\n", yytext);}
">="     	{printf("T_GEQ %s\n", yytext);}
">"		{printf("T_GT %s\n", yytext);}
"if"		{printf("T_IF %s\n", yytext);}
"int"		{printf("T_INTTYPE %s\n", yytext);}
"{"		{printf("T_LCB %s\n", yytext);}
"<<"		{printf("T_LEFTSHIFT %s\n", yytext);}
"("  {printf("T_LPAREN %s\n", yytext);}
"["  {printf("T_LSB %s\n", yytext);}
"<"  {printf("T_LT %s\n", yytext);}
"-"  {printf("T_MINUS %s\n", yytext);}
"%"  {printf("T_MOD %s\n", yytext);}
"*"  {printf("T_MULT %s\n", yytext);}
"!="  {printf("T_NEQ %s\n", yytext);}
"new"  {printf("T_NEW %s\n", yytext);}
"!"  {printf("T_NOT %s\n", yytext);}
"null" {printf("T_NULL %s\n", yytext);}
"||" {printf("T_OR %s\n", yytext);}
"+" {printf("T_PLUS %s\n", yytext);}
"}" {printf("T_RCB %s\n", yytext);}
"return" {printf("T_RETURN %s\n", yytext);}
">>" {printf("T_RIGHTSHIFT %s\n", yytext);}
")" {printf("T_RPAREN %s\n", yytext);}
"]" {printf("T_RSB %s\n", yytext);}
";" {printf("T_SEMICOLON %s\n", yytext);}
"true" {printf("T_TRUE %s\n", yytext);}
"string"  {printf("T_STRINGTYPE %s\n", yytext);}
"void" {printf("T_VOID %s\n", yytext);}
"while" {printf("T_WHILE %s\n", yytext);}

\\[^tnvfr]	{fprintf(stderr, "Error: invalid escape character");
			exit(1);
		}

[\t\n\v\r\ ]+	{int i; 
		printf("T_WHITESPACE ");
		for (i = 0; i < (int) yyleng; i++) {
			if(yytext[i] == '\n') printf("\\n");
			else printf("%c", yytext[i]);
		}
		printf("\n");
		}
(0x[0-9a-fA-F]+)|([0-9]+) {printf("T_INTCONSTANT %s\n", yytext);}
\".+\"	{printf("T_STRINGCONSTANT %s\n", yytext);}
\'(.|\\.)\'		{printf("T_CHARCONSTANT %s\n", yytext);}

[a-zA-Z_][a-zA-Z0-9_]*	{printf("T_ID %s\n", yytext);}


%%

int main () {
  int token; int i;
  while ((token = yylex())) {
    switch (token) {
      default: printf("%s", yytext);
    }
  }
  exit(0);
}

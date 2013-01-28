%{
#include <stdio.h>
#define UNTERM_S 100 
%}  

/* regexp definitions */
  int line_count = 0, char_count = 0;

%%


''		{fprintf(stderr, "Error: empty character\nLexical error: line %d, position %d\n", line_count, char_count);
			exit(1);
		}
'''		{fprintf(stderr, "Error: unescaped ' character\nLexical error: line %d, position %d\n", line_count, char_count);
			exit(1);
		}
'[^\\].'	{fprintf(stderr, "Error: char const length is greater than one\nLexical error: line %d, position %d\n", line_count, char_count);
			exit(1);
		}
\"\"		{fprintf(stderr, "Error: empty string\nLexical error: line %d, position %d\n", line_count, char_count);
			exit(1);
		}
'\\'		{fprintf(stderr, "Error: unescaped character\nLexical error: line %d, position %d\n", line_count, char_count);
			exit(1);
		}
\"\"\"		{fprintf(stderr, "Error: unterminated string constant\nLexical error: line %d, position %d\n", line_count, char_count);
			exit(1);
		}
\"\\[^tnvfrab\"]?\"	{fprintf(stderr, "Error: invalid escape character\nLexical error: line %d, position %d\n", line_count, char_count);
				exit(1);
			}
\"\n\"		{fprintf(stderr, "Error: newline mid string literal\nLexical error: line %d, position %d\n", line_count, char_count);
			exit(1);
		}



"&&"		{printf("T_AND %s\n", yytext); char_count+=(int)yyleng;}
"="		{printf("T_ASSIGN %s\n", yytext); char_count+=(int)yyleng;}
"bool"		{printf(" T_BOOL %s\n", yytext); char_count+=(int)yyleng;}
"break"		{printf("T_BREAK %s\n", yytext); char_count+=(int)yyleng;}
"class" 	{printf("T_CLASS %s\n", yytext); char_count+=(int)yyleng;}
"//".*\n	{int i;
		printf("T_COMMENT ");
			for(i=0; i< (int) yyleng - 1; i++) {
				printf("%c", yytext[i]);
				}
			printf("\\n\n");
      char_count = 0;
      line_count++;
		}	
","		{printf("T_COMMA %s", yytext); char_count+=(int)yyleng;}
"continue"	{printf("T_CONTINUE %s\n", yytext); char_count+=(int)yyleng;}
"/"		{printf("T_DIV %s\n", yytext); char_count+=(int)yyleng;}
"."		{printf("T_DOT %s\n", yytext); char_count+=(int)yyleng;}
"else"		{printf("T_ELSE %s\n", yytext); char_count+=(int)yyleng;}
"=="		{printf("T_EQ %s\n", yytext); char_count+=(int)yyleng;}
"extends"	{printf("T_EXTENDS %s\n", yytext); char_count+=(int)yyleng;}
"extern"	{printf("T_EXTERN %s\n", yytext); char_count+=(int)yyleng;}
"false"		{printf("T_FALSE %s\n", yytext); char_count+=(int)yyleng;}
"for"		{printf("T_FOR %s\n", yytext); char_count+=(int)yyleng;}
">="     	{printf("T_GEQ %s\n", yytext); char_count+=(int)yyleng;}
">"		{printf("T_GT %s\n", yytext); char_count+=(int)yyleng;}
"if"		{printf("T_IF %s\n", yytext); char_count+=(int)yyleng;}
"int"		{printf("T_INTTYPE %s\n", yytext); char_count+=(int)yyleng;}
"{"		{printf("T_LCB %s\n", yytext); char_count+=(int)yyleng;}
"<<"		{printf("T_LEFTSHIFT %s\n", yytext); char_count+=(int)yyleng;}
"("  {printf("T_LPAREN %s\n", yytext); char_count+=(int)yyleng;}
"["  {printf("T_LSB %s\n", yytext); char_count+=(int)yyleng;}
"<"  {printf("T_LT %s\n", yytext); char_count+=(int)yyleng;}
"-"  {printf("T_MINUS %s\n", yytext); char_count+=(int)yyleng;}
"%"  {printf("T_MOD %s\n", yytext); char_count+=(int)yyleng;}
"*"  {printf("T_MULT %s\n", yytext); char_count+=(int)yyleng;}
"!="  {printf("T_NEQ %s\n", yytext); char_count+=(int)yyleng;}
"new"  {printf("T_NEW %s\n", yytext); char_count+=(int)yyleng;}
"!"  {printf("T_NOT %s\n", yytext); char_count+=(int)yyleng;}
"null" {printf("T_NULL %s\n", yytext); char_count+=(int)yyleng;}
"||" {printf("T_OR %s\n", yytext); char_count+=(int)yyleng;}
"+" {printf("T_PLUS %s\n", yytext); char_count+=(int)yyleng;}
"}" {printf("T_RCB %s\n", yytext); char_count+=(int)yyleng;}
"return" {printf("T_RETURN %s\n", yytext); char_count+=(int)yyleng;}
">>" {printf("T_RIGHTSHIFT %s\n", yytext); char_count+=(int)yyleng;}
")" {printf("T_RPAREN %s\n", yytext); char_count+=(int)yyleng;}
"]" {printf("T_RSB %s\n", yytext); char_count+=(int)yyleng;}
";" {printf("T_SEMICOLON %s\n", yytext); char_count+=(int)yyleng;}
"true" {printf("T_TRUE %s\n", yytext); char_count+=(int)yyleng;}
"string"  {printf("T_STRINGTYPE %s\n", yytext); char_count+=(int)yyleng;}
"void" {printf("T_VOID %s\n", yytext); char_count+=(int)yyleng;}
"while" {printf("T_WHILE %s\n", yytext); char_count+=(int)yyleng;}

\\[^tnvfr]	{fprintf(stderr, "Error: invalid escape character");
			exit(1);
		}

[\t\n\v\r\ ]+	{int i; 
		printf("T_WHITESPACE ");
		for (i = 0; i < (int) yyleng; i++) {
			if(yytext[i] == '\n') {
        printf("\\n");
        char_count = 0;
        line_count++;
      }
			else {
        printf("%c", yytext[i]);
        char_count++;
      }		
    }
		printf("\n");
		}
(0x[0-9a-fA-F]+)|([0-9]+) {printf("T_INTCONSTANT %s\n", yytext); char_count+=(int)yyleng;}
\".+\"	{printf("T_STRINGCONSTANT %s\n", yytext); char_count+=(int)yyleng;}
\'(.|\\.)\'		{printf("T_CHARCONSTANT %s\n", yytext); char_count+=(int)yyleng;}

[a-zA-Z_][a-zA-Z0-9_]*	{printf("T_ID %s\n", yytext); char_count+=(int)yyleng;}


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

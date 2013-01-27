%{
#include <stdio.h>
#define T_CHARCONSTANT 262
#define T_CLASS    263
#define T_COMMENT  264
#define T_COMMA    265
#define T_CONTINUE 266
#define T_DIV      267
#define T_DOT      268
#define T_ELSE	   269
#define T_EQ	   270
#define T_EXTENDS  271
#define T_EXTERN   272
#define T_FALSE    273
#define T_FOR      274
#define T_GEQ      278
#define T_GT  	   279
#define T_IF       280
#define T_INTCONSTANT 281
#define T_INTTYPE  282
#define T_LCB      283
#define T_LEFTSHIFT 284
#define T_LEQ      285
#define T_LPAREN   286
#define T_LSB      287
#define T_LT       289
#define T_MINUS    290
#define T_MOD      291
#define T_MULT     292
#define T_NEQ      293
#define T_NEW      294
#define T_NOT      295
#define T_NULL     296
#define T_OR       297
#define T_PLUS     298
#define T_RCB      299
#define T_RETURN   300
#define T_RIGHTSHIFT 301
#define T_RPAREN   302
#define T_RSB      303
#define T_SEMICOLON 304
#define T_STRINGTYPE 305
#define T_STRINGCONSTANT 306
#define T_TRUE     307
#define T_VOID     308
#define T_WHILE    309
#define T_ID       310
#define T_WHITESPACE 311
%}  

/* regexp definitions */
num [0-9]+

%%

"&&"		{printf("T_AND %s\n", yylex());}
"="		{printf("T_ASSIGN %s\n", yylex());}
"bool"		{printf(" T_BOOL %s\n", yylex());}
"break"		{printf("T_BREAK %s\n", yylex());}

"class" 	{printf("T_CLASS %s\n", yylex());}
"//".*"\\n"	{prtinf("T_COMMENT %s\n", yylex());}
","		{printf("T_COMMA %s", yylex());}
"continue"	{printf("T_CONTINUE %s\n", yylex());}
"/"		{printf("T_DIV %s\n", yylex());}
"."		{printf("T_DOT %s\n", yyleX());}
"else"		{printf("T_ELSE %s\n", yylex());}
"=="		{printf("T_EQ %s\n", yylex());}
"extends"	{printf("T_EXTENDS %s\n", yyleX());}
"extern"	{printf("T_EXTERN %s\n", yylex());}
"false"		{printf("T_FALSE %s\n", yylex());}
"for"		{printf("T_FOR %s\n", yylex());}
">="     	{printf("T_GEQ %s\n", yylex());}
">"		{printf("T_GT %s\n", yylext());}
"if"		{printf("T_IF %s\n", yylext());}

"int"		{printf("T_INTTYPE %s\n", yylext());}
"{"		{printf("T_LCB %s\n", yylext());}
"<<"		{printf("T_LEFTSHIFT %s\n", yylext());}



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

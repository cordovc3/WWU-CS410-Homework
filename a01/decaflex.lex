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

"&&"		{printf("T_AND %s\n", yytext);}
"="		{printf("T_ASSIGN %s\n", yytext);}
"bool"		{printf(" T_BOOL %s\n", yytext);}
"break"		{printf("T_BREAK %s\n", yytext);}
"class" 	{printf("T_CLASS %s\n", yytext);}
"//".*"\\n"	{printf("T_COMMENT %s\n", yytext);}
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

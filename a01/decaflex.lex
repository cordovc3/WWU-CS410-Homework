%{
#include <stdio.h>
#define SINGLELINE 256
#define MULTILINE  257
#define AND	   258
#define T_ASSIGN   259
#define T_BOOLTYPE 260
#define T_BREAK    261
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

&&	{return T_AND;}
=	{return T_ASSIGN;}

">="     {return T_GEQ;}
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

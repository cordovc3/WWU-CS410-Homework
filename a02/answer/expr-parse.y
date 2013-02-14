%{
#include "expr-parse-defs.h"
#include <cstring>
#include <string>
#include <cstdarg>
#include <sstream>
#include <iostream>

  using namespace std;

  string *build_tree(const char *root, int n,...) {
    string *tree = new string;
    ostringstream s;
    va_list dtrs;
    va_start(dtrs, n);
    s << "(" << root;
    for (string *dtr = va_arg(dtrs, string *); n; dtr = va_arg(dtrs, string *), --n) {
      s << " " << *dtr;
      delete dtr;
    }
    s << ")";
    *tree = string(s.str());
    return tree;
  }

%}

%type <sval> f 
%type<sval> e
%type<sval> t

%union {
  string *sval;
}

%token <sval> PLUS "+"
%token <sval> TIMES "*"
%token <sval> LPAREN
%token <sval> RPAREN
%token ID
%%

e	:	e PLUS t {  $$ = build_tree($$, 3, $1, $2, $3);}
	|	t		 {$$ = build_tree($$, 1, $1); }
	;

t	:	t TIMES f { $$ = build_tree($$, 3, $1, $2, $3); }
	|	f		  { $$ = build_tree($$, 1, $1);  }
	;

f	:	LPAREN e RPAREN	{ $$ = build_tree($$, 3, $1, $2, $3); } 
	|	ID				{   }
	;

%%

int main() {
	return yyparse();
}


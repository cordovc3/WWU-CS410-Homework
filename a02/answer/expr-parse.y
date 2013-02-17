%{
#include "expr-parse-defs.h"
#include <cstring>
#include <string>
#include <cstdarg>
#include <sstream>
#include <iostream>
#include <sstream>

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


%union {
   char *sval;
   string *tval;
}

%token <sval> PLUS "+"
%token <sval> TIMES "*"
%token <sval> LPAREN "\\("
%token <sval> RPAREN "\\)"
%token <sval> ID
%type <tval> f
%type <tval> e
%type <tval> t
%%

e	:	e PLUS t {string * tval = new string; tval = build_tree("e", 3, $1, $2, $3); $$ = tval; } 
	|	t	 { string * tval = new string; tval = build_tree("e", 1, $1); $$ = tval; }
	;

t	:	t TIMES f { string * tval = new string; tval = build_tree("t", 3, $1, $2, $3); $$ = tval; }
	|	f	  { $$ = build_tree("t", 1, $1);  }
	;

f	:	LPAREN e RPAREN	{ string *tval = new string; tval = build_tree("f", 3, $1, $2, $3); $$ = tval; } 
	|	ID		{ string *tval = new string; tval = build_tree("ID", 1, yylval.sval); $$ = tval;  }
	;

%%

int main() {
	return yyparse();
}


%{
/*WWU CS410 HW2 Q5
    Josh Wisdom
    Kyle Coffin
    Charles Cordova
    Nicholas Beichley */

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

  string str1;

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
%type <tval> start
%%

start	:	e	{cout << *$$ << endl;}
	;

e	:	e PLUS t { $$ = build_tree("e",3, $1, build_tree("PLUS", 1, new string("+")), $3); }
	|	t	 { $$ = build_tree("e", 1, $1); }
	;

t	:	t TIMES f { $$ = build_tree("t", 3, $1, build_tree("TIMES", 1, new string("*")), $3); }
	|	f	  { $$ = build_tree("t", 1, $1); }
	;

f	:	LPAREN e RPAREN	{ $$ = build_tree("f", 3, build_tree("LPAREN", 1, new string("\\(")), $2, build_tree("RPAREN", 1, new string("\\)"))); } 
	|	ID		{ $$ = build_tree("f", 1, build_tree("ID", 1, new string (yylval.sval))); }
	;

%%

int main() {
	return yyparse();
}


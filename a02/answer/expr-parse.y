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

/* %union {
  string *sval;
} */

%token PLUS TIMES LPAREN RPAREN ID

%%

e	:	e PLUS t {  cout << "E goes to e plus t action\n";}
	|	t		 { cout << "E goes to t\n";}
	;

t	:	t TIMES f { cout << "T goes to t times t action \n"; }
	|	f		  { cout << "T goes to f\n"; }
	;

f	:	LPAREN e RPAREN	{ cout << "f goes to lparen e rparen\n"; }
	|	ID				{ cout << "f goes to id\n"; }
	;

%%

int main() {
	return yyparse();
}


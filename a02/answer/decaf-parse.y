%{
#include "decaf-parse-defs.h"
#include <cstring>
#include <string>
#include <cstdarg>
#include <sstream>
#include <iostream>

  using namespace std;

#define EMPTYSTRING "EPSILON"

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
  string *sval;
}

%token <sval> T_AND
%token <sval> T_ASSIGN
%token <sval> T_BOOLTYPE
%token <sval> T_BREAK
%token <sval> T_CHARCONSTANT
%token <sval> T_CLASS
%token <sval> T_COMMENT
%token <sval> T_COMMA
%token <sval> T_CONTINUE
%token <sval> T_DIV
%token <sval> T_DOT
%token <sval> T_ELSE
%token <sval> T_EQ
%token <sval> T_EXTENDS
%token <sval> T_EXTERN
%token <sval> T_FALSE
%token <sval> T_FOR
%token <sval> T_GEQ
%token <sval> T_GT
%token <sval> T_IF
%token <sval> T_INTCONSTANT
%token <sval> T_INTTYPE
%token <sval> T_LCB
%token <sval> T_LEFTSHIFT
%token <sval> T_LEQ
%token <sval> T_LPAREN
%token <sval> T_LSB
%token <sval> T_LT
%token <sval> T_MINUS
%token <sval> T_MOD
%token <sval> T_MULT
%token <sval> T_NEQ
%token <sval> T_NEW
%token <sval> T_NOT
%token <sval> T_NULL
%token <sval> T_OR
%token <sval> T_PLUS
%token <sval> T_RCB
%token <sval> T_RETURN
%token <sval> T_RIGHTSHIFT
%token <sval> T_RPAREN
%token <sval> T_RSB
%token <sval> T_SEMICOLON
%token <sval> T_STRINGTYPE
%token <sval> T_STRINGCONSTANT
%token <sval> T_TRUE
%token <sval> T_VOID
%token <sval> T_WHILE
%token <sval> T_ID
%token <sval> T_WHITESPACE

%type <sval> assign
%type <sval> assign_comma_list
%type <sval> block
%type <sval> bool_constant
%type <sval> class
%type <sval> class_name
%type <sval> constant
%type <sval> expr
%type <sval> extern_defn
%type <sval> extern_type_list
%type <sval> extern_list
%type <sval> extern_type
%type <sval> field
%type <sval> field_decl
%type <sval> field_decl_list
%type <sval> field_list
%type <sval> id_comma_list
%type <sval> lvalue
%type <sval> method_arg
%type <sval> method_arg_list
%type <sval> method_call
%type <sval> method_decl
%type <sval> method_decl_list
%type <sval> method_type
%type <sval> param
%type <sval> param_comma_list
%type <sval> param_list
%type <sval> program
%type <sval> statement
%type <sval> statement_list
%type <sval> type
%type <sval> var_decl
%type <sval> var_decl_list

%type <sval> start

%left T_OR
%left T_AND
%left T_EQ T_NEQ
%left T_LT T_LEQ T_GEQ T_GT
%left T_LEFTSHIFT T_RIGHTSHIFT
%left T_MOD
%left T_PLUS T_MINUS
%left T_MULT T_DIV
%left T_NOT
%right UMINUS

%%

start: program
  {
    cout << *$1 << endl;
    delete $1;
  }

program: extern_list class
  {
    $$ = build_tree("program", 2, $1, $2);
  }

extern_list: extern_list extern_defn
  {
    $$ = build_tree("extern_list", 2, $1, $2);
  }
  | /* extern_list can be empty */
  {
    $$ = build_tree("extern_list", 1, new string(EMPTYSTRING));
  }
  ;

extern_defn: T_EXTERN method_type T_ID T_LPAREN extern_type_list T_RPAREN T_SEMICOLON
  {
    $$ = build_tree("extern_defn", 7, $1, $2, $3, $4, $5, $6, $7);
  }
  | T_EXTERN method_type T_ID T_LPAREN T_RPAREN T_SEMICOLON
  {
    $$ = build_tree("extern_defn", 6, $1, $2, $3, $4, $5, $6);
  }
  ;

extern_type_list: extern_type
  {
    $$ = build_tree("extern_type_list", 1, $1);
  }
  | extern_type T_COMMA extern_type_list
  {
    $$ = build_tree("extern_type_list", 3, $1, $2, $3);
  }
  ;

extern_type: T_STRINGTYPE
  {
    $$ = build_tree("extern_type", 1, $1);
  }
  | type
  {
    $$ = build_tree("extern_type", 1, $1);
  }
  ;

class: T_CLASS class_name T_LCB field_decl_list method_decl_list T_RCB
  {
    $$ = build_tree("class", 6, $1, $2, $3, $4, $5, $6);
  }
     | T_CLASS class_name T_LCB field_decl_list T_RCB
  {
    $$ = build_tree("class", 5, $1, $2, $3, $4, $5);
  }
     ;

field_decl_list: field_decl_list field_decl
  {
    $$ = build_tree("field_decl_list", 2, $1, $2);
  }
     | /* empty */ 
  {
    $$ = build_tree("field_decl_list", 1, new string(EMPTYSTRING));
  }
     ;

method_decl_list: method_decl_list method_decl
  {
    $$ = build_tree("method_decl_list", 2, $1, $2);
  }
     | method_decl
  {
    $$ = build_tree("method_decl_list", 1, $1);
  }
     ;

class_name: T_ID
  {
    $$ = build_tree("class_name", 1, $1);
  }

field_decl: type field_list T_SEMICOLON
  {
    $$ = build_tree("field_decl", 3, $1, $2, $3);
  }
     | type T_ID T_ASSIGN constant T_SEMICOLON
  {
    $$ = build_tree("field_decl", 5, $1, $2, $3, $4, $5);
  }
     ;

field_list: field T_COMMA field_list
  {
    $$ = build_tree("field_list", 3, $1, $2, $3);
  }
     | field
  {
    $$ = build_tree("field_list", 1, $1);
  }
     ;

field: T_ID
  {
    $$ = build_tree("field", 1, $1);
  }
     | T_ID T_LSB T_INTCONSTANT T_RSB
  {
    $$ = build_tree("field", 4, $1, $2, $3, $4);
  }
     ;

method_decl: T_VOID T_ID T_LPAREN param_list T_RPAREN block
  {
    $$ = build_tree("method_decl", 6, $1, $2, $3, $4, $5, $6);
  }
     | type T_ID T_LPAREN param_list T_RPAREN block
  {
    $$ = build_tree("method_decl", 6, $1, $2, $3, $4, $5, $6);
  }
     ;

method_type: T_VOID
  {
    $$ = build_tree("method_type", 1, $1);
  }
    | type
  {
    $$ = build_tree("method_type", 1, $1);
  }
    ;

param_list: param_comma_list
  {
    $$ = build_tree("param_list", 1, $1);
  }
     | /* empty */
  {
    $$ = build_tree("param_list", 1, new string(EMPTYSTRING));
  }
     ;

param_comma_list: param T_COMMA param_comma_list
  {
    $$ = build_tree("param_comma_list", 3, $1, $2, $3);
  }
     | param
  {
    $$ = build_tree("param_comma_list", 1, $1);
  }
     ;

param: type T_ID
  {
    $$ = build_tree("param", 2, $1, $2);
  }

type: T_INTTYPE
  {
    $$ = build_tree("type", 1, $1);
  }
     | T_BOOLTYPE
  {
    $$ = build_tree("type", 1, $1);
  }
     ;

block: T_LCB var_decl_list statement_list T_RCB
  {
    $$ = build_tree("block", 4, $1, $2, $3, $4);
  }

var_decl_list: var_decl var_decl_list
  {
    $$ = build_tree("var_decl_list", 2, $1, $2);
  }
     | /* empty */
  {
    $$ = build_tree("var_decl_list", 1, new string(EMPTYSTRING));
  }
     ;

statement_list: statement statement_list
  {
    $$ = build_tree("statement_list", 2, $1, $2);
  }
     | /* empty */ 
  {
    $$ = build_tree("statement_list", 1, new string(EMPTYSTRING));
  }
     ;

var_decl: T_INTTYPE T_ID id_comma_list T_SEMICOLON
  {
    $$ = build_tree("var_decl", 4, $1, $2, $3, $4);
  }
     | T_BOOLTYPE T_ID id_comma_list T_SEMICOLON
  {
    $$ = build_tree("var_decl", 4, $1, $2, $3, $4);
  }
     ;

id_comma_list: /* empty */ 
  {
    $$ = build_tree("id_comma_list", 1, new string(EMPTYSTRING));
  }
     | T_COMMA T_ID id_comma_list
  {
    $$ = build_tree("id_comma_list", 3, $1, $2, $3);
  }
     ;



lvalue: T_ID
  {
    $$ = build_tree("lvalue", 1, $1);
  }
     | T_ID T_LSB expr T_RSB
  {
    $$ = build_tree("lvalue", 4, $1, $2, $3, $4);
  }
     ;

expr: lvalue
  {
    $$ = build_tree("expr", 1, $1);
  }
     | method_call
  {
    $$ = build_tree("expr", 1, $1);
  }
     | constant
  {
    $$ = build_tree("expr", 1, $1);
  }
     | expr T_PLUS expr
  {
    $$ = build_tree("expr", 3, $1, $2, $3);
  }
     | expr T_MINUS expr
  {
    $$ = build_tree("expr", 3, $1, $2, $3);
  }
     | expr T_MULT expr
  {
    $$ = build_tree("expr", 3, $1, $2, $3);
  }
     | expr T_DIV expr
  {
    $$ = build_tree("expr", 3, $1, $2, $3);
  }
     | expr T_LEFTSHIFT expr
  {
    $$ = build_tree("expr", 3, $1, $2, $3);
  }
     | expr T_RIGHTSHIFT expr
  {
    $$ = build_tree("expr", 3, $1, $2, $3);
  }
     | expr T_MOD expr
  {
    $$ = build_tree("expr", 3, $1, $2, $3);
  }
     | expr T_LT expr
  {
    $$ = build_tree("expr", 3, $1, $2, $3);
  }
     | expr T_GT expr
  {
    $$ = build_tree("expr", 3, $1, $2, $3);
  }
     | expr T_LEQ expr
  {
    $$ = build_tree("expr", 3, $1, $2, $3);
  }
     | expr T_GEQ expr
  {
    $$ = build_tree("expr", 3, $1, $2, $3);
  }
     | expr T_EQ expr
  {
    $$ = build_tree("expr", 3, $1, $2, $3);
  }
     | expr T_NEQ expr
  {
    $$ = build_tree("expr", 3, $1, $2, $3);
  }
     | expr T_AND expr
  {
    $$ = build_tree("expr", 3, $1, $2, $3);
  }
     | expr T_OR expr
  {
    $$ = build_tree("expr", 3, $1, $2, $3);
  }
     | T_MINUS expr %prec UMINUS 
  {
    $$ = build_tree("expr", 2, $1, $2);
  }
     | T_NOT expr
  {
    $$ = build_tree("expr", 2, $1, $2);
  }
     | T_LPAREN expr T_RPAREN
  {
    $$ = build_tree("expr", 3, $1, $2, $3);
  }
     ;

constant: T_INTCONSTANT
  {
    $$ = build_tree("constant", 1, $1);
  }
     | T_CHARCONSTANT
  {
    $$ = build_tree("constant", 1, $1);
  }
     | bool_constant
  {
    $$ = build_tree("constant", 1, $1);
  }
     ;

bool_constant: T_TRUE
  {
    $$ = build_tree("bool_constant", 1, $1);
  }
     | T_FALSE
  {
    $$ = build_tree("bool_constant", 1, $1);
  }
     ;

%%



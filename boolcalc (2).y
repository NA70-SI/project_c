%{
#include<stdio.h>
#include<math.h>

int yylex (void);
extern int yyparse();
extern FILE* yyin;

void yyerror (char const *);
%}

%define api.value.type {int}

%token BOOL
%token AND
%token OR
%token NOT
%left '&'
%left '|'
%left '!'
%token NEWLINE
%start input


%%

input:
  %empty
| input line
;

line:
  NEWLINE
| exp NEWLINE {printf("%s\n", $1 ? "TRUE" : "FALSE"); }
;

exp:
  BOOL
| exp exp AND {$$ = $1 && $2;}
| exp exp OR {$$ = $1 || $2;}
| exp NOT {$$ = !$1;}
;
%%


void yyerror (char const *s){
  fprintf(stderr, "%s\n",s);
}

int main(void){
  yyin = stdin;
  do {
	yyparse();
  } while (!feof(yyin));
  return 0;
}  

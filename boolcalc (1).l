%{
  #include <stdio.h>
  #include "boolcalc.tab.h"
%}
%option noyywrap

%%

[ \t]	;
[01]|[fF][aA][lL][sS][eE]|[tT][rR][uU][eE] 	{yylval = (*yytext == '0' ||*yytext == 'f' || *yytext == 'F') ?  0 : 1 ; return BOOL;}
\n				{return NEWLINE;}
\&				{return AND;}
\|                              {return OR;}
\!                              {return NOT;}
.                               {fprintf(stderr, "Invalid character: %s\n", yytext); }

%%


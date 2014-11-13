/* Hongzi Mao hmao 2002 5238 */
%option yylineno

%{
#define YYSTYPE char *
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parseconfig.tab.h"
extern YYSTYPE yylval;
char *getprefixnum(const char *); /* Provided */
%}

/* Flex definitions */
digits [0-9]
prefix [/][ \t]*{digits}+
/************* Start: add your definitions here */

letter [a-zA-Z]
letterordigit ({letter}|{digits})*

nn     [1-9]
ff     [0-4]
vv     [0-5]
ii     ({digits}|{nn}{digits}|1{digits}{digits}|2{ff}{digits}|25{vv})

ws     [ \t\n]+
ip     {ii}\.{ii}\.{ii}\.{ii}
sb     [;,-\{\}]
/* End: add your definitions here */

%%
interface return INTERFACE;
pool return POOL;
whitelist return WHITELIST;
blacklist return BLACKLIST;
{prefix} {yylval = getprefixnum(yytext); return PREFIX;}
 /************* Start: add your rules here. */
 /* Start in the first column, no leading spaces.*/

{ws} /* eats up white spaces and newline*/
{letter} {yylval = strdup(yytext); return LETTER;}
{digits} {yylval = strdup(yytext); return DIGIT;} 
{ip} {yylval = strdup(yytext); return IP;}
{sb} {yylval = strdup(yytext); return *yytext;}

 /* End: add your rules here */
%%

char *getprefixnum(const char *text)
{
    const char *p = text;
    while(p != NULL && !(*p >= '0' && *p <= '9')) ++p;
    return strdup(p);
}

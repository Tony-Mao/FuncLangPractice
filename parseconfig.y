/* Hongzi Mao hmao 2002 5238 */
%{
#define YYSTYPE char *
#include <math.h>
#include <stdio.h>
#include <string.h>
#include <arpa/inet.h>

#define MAXIPNUM 65536

int ipmap[MAXIPNUM]; /* IP array to store IP pools */

FILE *yyin;
int yylex();
int yywrap();
int yyerror(const char*);

/* Functions to process IP, all are provided. */
int ipstrtoint(const char *ipstr);
void inttoipstr(int ip, char *ipstr);
void outputiplist();
void addsubnet(const char *ipstr, int prefixlen);
void addrange(const char *ipminstr, const char *ipmaxstr);
void addip(const char *ipstr);
void deleteip(const char *ipstr);
/* Functions to process IP End */
%}

/* Define tokens here */
%token INTERFACE POOL WHITELIST BLACKLIST IP PREFIX
 /************* Start: add your tokens here */
%token LETTER DIGIT



/* End: add your tokens here */

%% /* Grammer rules and actions follow */
commands: /*empty*/
| commands command 
;
/************* Start: add your grammar rules here */
command:
INTERFACE name poolblock list 
;
name:
letter letterordigit {printf(":\n");}
;
letter:
LETTER {printf("%s", $1);}
;
letterordigit: /*empty*/
| letterordigit LETTER{printf("%s", $2);}
| letterordigit DIGIT{printf("%s", $2);}
;
poolblock: 
'{' pools '}' 
;
pools: /*empty*/
| pools poolslash 
| pools poolrange
;
poolslash:
POOL IP PREFIX ';' {addsubnet($2, atoi($3));}
;
poolrange:
POOL IP '-' IP ';' {addrange($2, $4);}
;
list: /*empty*/
| list whitelist
| list blacklist
;
whitelist:
WHITELIST '{' whiplist IP ';' '}' {addip($4);}
;
whiplist: /*empty*/
| whiplist IP ',' {addip($2);}
;
blacklist:
BLACKLIST '{' biplist IP ';' '}' {deleteip($4);}
;
biplist: /*empty*/
| biplist IP ',' {deleteip($2);}
;

/* End: add your grammar rules here */
%%

int main(int argc, char *argv[])
{
    // init the ipmap
    memset(ipmap, 0, sizeof(ipmap));
    FILE *fconfig = fopen(argv[1], "r");
    // make sure it is valid
    if (!fconfig)
    {
        printf ("Error reading file!\n");
        return -1;
    }
    // set lex to read from file
    yyin = fconfig;
    yyparse();
    outputiplist();
}

int yywrap()
{
    return 1;
}

int yyerror(const char* s)
{
    extern int yylineno;
    extern char *yytext;
    printf("\n^%d: %s at %s #%d\n", yylineno, s, yytext, (int)(*yytext));
    return 0;
}

int ipstrtoint(const char* ipstr)
{
    int ret = 0;
    struct in_addr addr;
    if(inet_aton(ipstr, &addr) == 0)
    {
        printf("Invalid IP string!\n");
        return ret;
    }
    ret = ntohl(addr.s_addr);
    return ret;
}

void inttoipstr(int ip, char *ipstr)
{
    struct in_addr addr;
    addr.s_addr = htonl(ip);
    char *p = inet_ntoa(addr);
    strcpy(ipstr, p);
}

void addsubnet(const char *ipstr, int prefixlen)
{
    int ip = ipstrtoint(ipstr);
    int mask = ~0<<(32 - prefixlen), i;
    for(i = ((ip & mask) + 1); i <= (ip | (~mask)); ++i)
        ipmap[i] = 1;
}

void addrange(const char *ipminstr, const char *ipmaxstr)
{
    int ipmin = ipstrtoint(ipminstr);
    int ipmax = ipstrtoint(ipmaxstr);
    if (ipmin < 0 || ipmin >= MAXIPNUM) return;
    if (ipmax < 0 || ipmax >= MAXIPNUM) return;
    int i;
    for(i = ipmin; i <= ipmax; ++i)
        ipmap[i] = 1;
}

void addip(const char *ipstr)
{
    int ip = ipstrtoint(ipstr);
    if (ip >= 0 && ip < MAXIPNUM)
        ipmap[ip] = 1;
}

void deleteip(const char *ipstr)
{
    int ip = ipstrtoint(ipstr);
    if (ip >= 0 && ip < MAXIPNUM)
        ipmap[ip] = 0;
}

void outputiplist()
{
    char str[100];
    int i;
    for(i = 0; i < MAXIPNUM; ++i)
    {
        if (ipmap[i] == 1)
        {
            inttoipstr(i, str);
            printf("%s \n", str);
        }
    }
}

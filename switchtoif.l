%{
char var_name[20];
#include<string.h>
int flag;
%}
text [a-zA-Z_]
num [0-9]
%s VAR
%s CASES
%s COND

%%
"switch(" {  BEGIN VAR;}
<VAR>[a-z]+ { strcpy(var_name, yytext);}
<VAR>")"[\n]?[{] {BEGIN CASES;}
<CASES>"case " {
    if(flag == 0)
    {
        printf("if(");
        flag = 1;
    }
    else
        printf("else if(");
    BEGIN COND;
}
<CASES>"break;" {
    printf("}\n");
}

<CASES>"default:" {
    printf("else{");
}
<COND>{num}+[:] {
    yytext[yyleng - 1] = '\0';
    printf("%s == %s)\n{", var_name, yytext);
    BEGIN CASES;
}


%%
int main()
{
    flag = 0;
    yyin=fopen("switch.txt","r");
    yylex();
    fclose(yyin);
    return 0;
}
int yywrap()
{
    return 1;
}			
%{
int i=0,j=0,k=0,arg[10][20],mname[20];
%}
%s START
%s ARG
%s END
%%
<INITIAL>"#define " {BEGIN START;}
<INITIAL>. {printf("%s",yytext);}
<START>[a-zA-Z0-9]+ {//strcpy(mname,yytext);
        printf("\nint %s",yytext);
        }
<START>[(] {printf("%s",yytext);
		BEGIN ARG;
		}
<ARG>[^,()] {//strcpy(arg[i++],yytext);
        printf("int %s",yytext);
        }
<ARG>[,] {printf("%s",yytext);}
<ARG>")" {printf("%s\n{",yytext);
        BEGIN END;
        }
<END>[^\n]+ {
        printf("\n return %s\n}\n",yytext);
        BEGIN INITIAL;
        }
%%
int main()
{
        yylex();
        return 0;
}        
int yywrap()
{
	return 1;
}
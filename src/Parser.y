{
module Parser where
import Scanner
}

%name csvql
%tokentype { Token }

%token
    "select"            { TSelect }
%%

Select :
    "select"            { SSelect }

{

data SSelect = SSelect deriving Show

}


{
module Parser where
import Scanner
}

%name csvql
%tokentype { Token }
%error { parseError }

%token
    "select"            { TSelect }
%%

Select :
    "select"            { SSelect }

{

parseError :: [Token] -> a
parseError _ = error "Parse error"

data SSelect = SSelect deriving Show

}


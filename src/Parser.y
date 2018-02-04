{
module Parser where
import Scanner
}

%name csvql
%tokentype { Token }
%error { parseError }

%token
    "Select"            { TSelect }
    "Where"             { TWhere }
    "*"                 { TAll }
    field               { TVar $$ }
%%

Query :
    Select SelectExpr               { Query }

Select :
    "Select"                        { SSelect }

SelectExpr :
    field                           { ExpField $1 }
    | "*"                           { ExpAll }

{

parseError :: [Token] -> a
parseError _ = error "Parse error"

data Query = Query deriving Show
data SSelect = SSelect deriving Show
data Exp = ExpField String | ExpAll

}


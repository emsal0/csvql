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
    Select SelectExpr               { Query $1 $2 }

Select :
    "Select"                        { SSelect }

SelectExpr :
    field                           { ExpField $1 }
    | "*"                           { ExpAll }

{

parseError :: [Token] -> a
parseError _ = error "Parse error"

data Query = Query SSelect Exp deriving (Show, Eq)
data SSelect = SSelect deriving (Show, Eq)
data Exp = ExpField String | ExpAll
    deriving (Show, Eq)

}


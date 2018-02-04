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
    "From"              { TFrom }
    "*"                 { TAll }
    field               { TVar $$ }
%%

Query :
    "Select" SelectExpr FromExpr    { Query $2 $3 }


SelectExpr :
    field                           { ExpField $1 }
    | "*"                           { ExpAll }

FromExpr:
    "From" field                    { FromExp $2 }

{

parseError :: [Token] -> a
parseError _ = error "Parse error"

data Query = Query Exp FromExp deriving (Show, Eq)
data Exp = ExpField String | ExpAll
    deriving (Show, Eq)
data FromExp = FromExp String deriving (Show, Eq)

}


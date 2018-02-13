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
    "and"               { TAnd }
    "or"                { TOr }
    "."                 { TDot }
    "'"                 { TQuot }
    field               { TVar $$ }
    sym                 { TSym $$ }
    int                 { TInt $$ }
%%

Query :
    "Select" SelectExpr FromExpr                { Query $2 $3 }
    | "Select" SelectExpr FromExpr WhereExpr    { FilteredQuery $2 $3 $4 }


SelectExpr :
    FieldExpr                       { SelectField $1 }
    | "*"                           { SelectAll }

FromExpr:
    "From" SourceExpr               { FromExp $2 }

WhereExpr:
    "Where" Clause                  { WhereExp $2 }

Clause:
    FieldExpr sym int               { BaseClause $1 $2 $3 }
    | Clause "and" Clause           { AndClause $1 $3 }
    | Clause "or" Clause            { OrClause $1 $3 }

SourceExpr:
    field                           { SourceExp $1 }
    | field "." field               { SourceExp ($1 ++ "." ++ $3) }

FieldExpr:
    field                           { FieldExp $1 }
    | FieldExpr "." field           { FieldRefExp $1 $3 }

{

parseError :: [Token] -> a
parseError _ = error "Parse error"

data Query = Query SelectExp FromExp
    | FilteredQuery SelectExp FromExp WhereExp
    deriving (Show, Eq)

data SelectExp = SelectField FieldExp | SelectAll
    deriving (Show, Eq)

data FromExp = FromExp SourceExp deriving (Show, Eq)

data WhereExp = WhereExp Clause deriving (Show, Eq)

data Clause =
    BaseClause FieldExp String Int
    | AndClause Clause Clause
    | OrClause Clause Clause
    deriving (Show, Eq)

data FieldExp = FieldExp String | FieldRefExp FieldExp String deriving (Show, Eq)

data SourceExp = SourceExp String deriving (Show, Eq)

}


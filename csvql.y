{
module Main where
import Scanner
}

%name csvql
%tokentype { Token }

%token
    select            { TSelect }
%%

Program :
    SelectStatement

SelectStatement :
    select

{

data Program = Program SelectStatement deriving (Show, Eq)

data SelectStatement = SelectStatement deriving (Show, Eq)

main = do 
    putStrLn "done"
}


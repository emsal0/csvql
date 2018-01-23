{
module Main where
import Scanner
}

%name csvql
%tokentype { Token }

%token
    "select"            { TSelect }
%%

Program :
    Select

Select:
    "select"

{
main = do 
    putStrLn "done"
}


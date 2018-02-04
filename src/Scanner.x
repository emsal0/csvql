{
module Scanner where
}

%wrapper "basic"

$digit = 0-9            -- digits
$alpha = [a-zA-Z]       -- alphabetic characters

tokens :-

    $white+                                           ;
    "--".*                                            ;
    SELECT | select                                   { \s -> TSelect }
    WHERE | where                                     { \s -> TWhere }
    FROM | from                                       { \s -> TFrom }
    let                                               { \s -> Let }
    in                                                { \s -> In }
    $digit+                                           { \s -> Int (read s) }
    \<\= | \>\= | [\>\<\=\+\-\*\/\(\)]                { \s -> Sym s }
    $alpha [$alpha $digit \_ \']*                     { \s -> Var s }
    \. [$alpha $digit \_ \']*                         { \s -> FieldRef (tail s) }

{
-- Each action has type :: String -> Token

-- The token type:
data Token =
    Let                     |
    In                      |
    Sym String              |
    Var String              |
    FieldRef String         |
    Int Int                 |
    TSelect                 |
    TFrom                   |
    TWhere deriving (Eq,Show)

}

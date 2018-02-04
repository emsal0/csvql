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
    let                                               { \s -> TLet }
    in                                                { \s -> TIn }
    $digit+                                           { \s -> TInt (read s) }
    \*                                                { \s -> TAll }
    \<\= | \>\= | [\>\<\=\+\-\/\(\)]                  { \s -> TSym s }
    $alpha [$alpha $digit \_ \']*                     { \s -> TVar s }
    \. [$alpha $digit \_ \']*                         { \s -> TFieldRef (tail s) }

{
-- Each action has type :: String -> Token

-- The token type:
data Token =
    TLet                     |
    TIn                      |
    TSym String              |
    TVar String              |
    TAll                     |
    TFieldRef String         |
    TInt Int                 |
    TSelect                  |
    TFrom                    |
    TWhere deriving (Eq,Show)

}

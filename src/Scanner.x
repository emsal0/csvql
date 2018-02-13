{
module Scanner where
}

%wrapper "basic"

$digit = 0-9            -- digits
$alpha = [a-zA-Z]       -- alphabetic characters

tokens :-

    $white+                                           ;
    "--".*                                            ;
    \\SELECT | \\select                               { \s -> TVar "select" }
    \\WHERE | \\where                                 { \s -> TVar "where" }
    \\FROM | \\from                                   { \s -> TVar "from" }
    \\AND | \\and                                     { \s -> TVar "and" }
    \\OR | \\or                                       { \s -> TVar "or" }
    SELECT | select                                   { \s -> TSelect }
    WHERE | where                                     { \s -> TWhere }
    FROM | from                                       { \s -> TFrom }
    AND | and                                         { \s -> TAnd }
    OR | or                                           { \s -> TOr }
    $digit+                                           { \s -> TInt (read s) }
    \*                                                { \s -> TAll }
    \'                                                { \s -> TQuot }
    \<\= | \>\= | [\>\<\=\+\-\/\(\)]                  { \s -> TSym s }
    $alpha [$alpha $digit \_ \' \/ \\]*               { \s -> TVar s }
    \.                                                { \s -> TDot }

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
    TQuot                    |
    TDot                     |
    TFrom                    |
    TAnd                     |
    TOr                      |
    TWhere deriving (Eq,Show)

}

{
module Scanner where
}

%wrapper "basic"

$digit = 0-9            -- digits
$alpha = [a-zA-Z]       -- alphabetic characters

tokens :-

    $white+                                           ;
    "--".*                                            ;
    SELECT                                            { \s -> TSelect }
    select                                            { \s -> TSelect }
    WHERE                                             { \s -> TWhere }
    where                                             { \s -> TWhere }
    FROM                                              { \s -> TFrom }
    from                                              { \s -> TFrom }
    let                                               { \s -> Let }
    in                                                { \s -> In }
    $digit+                                           { \s -> Int (read s) }
    [\< '\<\=' \> '\>\=' \= \+ \- \* \/ \(\)]         { \s -> Sym (head s) }
    $alpha [$alpha $digit \_ \']*                     { \s -> Var s }
    \. [$alpha $digit \_ \']*                         { \s -> FieldRef (tail s) }
    
{
-- Each action has type :: String -> Token

-- The token type:
data Token =
    Let                     |
    In                      |
    Sym Char                |
    Var String              |
    FieldRef String         |
    Int Int                 |
    TSelect                 |
    TFrom                   |
    TWhere deriving (Eq,Show)

}

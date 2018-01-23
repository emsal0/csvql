{
module Scanner where
}

%wrapper "basic"

$digit = 0-9            -- digits
$alpha = [a-zA-Z]       -- alphabetic characters

tokens :-

  $white+                               ;
  "--".*                                ;
  "SELECT"                              { \s -> Select }
  "select"                              { \s -> select }
  "WHERE"                               { \s -> Where }
  "where"                               { \s -> Where }
  let                                   { \s -> Let }
  in                                    { \s -> In }
  $digit+                               { \s -> Int (read s) }
  [\=\+\-\*\/\(\)]                      { \s -> Sym (head s) }
  $alpha [$alpha $digit \_ \']*         { \s -> Var s }

{
-- Each action has type :: String -> Token

-- The token type:
data Token =
    Let         |
    In          |
    Sym Char    |
    Var String  |
    Int Int     |
    Select      |
    Where
    deriving (Eq,Show)

}

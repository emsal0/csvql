module Parser2 where
import Scanner

import Text.Parsec.String (Parser)
import Text.Parsec.Char (anyChar)
import Text.Parsec.Char
import Text.Parsec
import Data.Char
import Text.Parsec.Combinator (many1)

type Parser = Parsec [Token] ()

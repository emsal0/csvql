module Main where
import Parser
import Scanner
import Data.Csv
import qualified Data.ByteString.Lazy as BL

-- evaluate :: Query -> something idk

main = do
    s <- getContents
    let tokens = (alexScanTokens s)
    print tokens
    let parseTree = csvql tokens
    putStrLn ("parseTree: " ++ show(parseTree))
    print "done"

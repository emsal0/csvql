module Main where
import Parser
import Scanner
import Data.Csv
import qualified Data.ByteString.Lazy as BL

evaluate :: Query -> IO BL.ByteString

evaluate (Query selectExp (FromExp f) ) = do
    csvData <- BL.readFile (f ++ ".csv")
    return csvData

evaluate (FilteredQuery selectExp fromExp whereExp) = return BL.empty

main :: IO ()
main = do
    s <- getContents
    let tokens = (alexScanTokens s)
    print tokens
    let parseTree = csvql tokens
    putStrLn ("parseTree: " ++ show(parseTree))
    f <- evaluate parseTree
    putStrLn ("query result: " ++ show(f))
    print "done"

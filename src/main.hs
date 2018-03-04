module Main where
import Parser
import Scanner
import qualified Data.ByteString.Lazy as BL
import Data.ByteString (ByteString)
import Data.Csv
import qualified Data.Vector as V

evaluate :: Query -> IO String

evaluate (Query selectExp (FromExp (SourceExp f)) ) = do
    csvData <- BL.readFile (f)
    case decode HasHeader csvData :: Either String (V.Vector (V.Vector ByteString)) of
        Left err -> return err
        Right v -> return (show v)

evaluate (FilteredQuery selectExp fromExp whereExp) = return ""

-- Where expressions
evaluateWhere :: WhereExp -> Record -> Bool
evaluateWhere whereExp = \r -> True

-- Clauses
evaluateClause :: Clause -> Either String Int -> Bool

evaluateClause c = \c -> True


main :: IO ()
main = do
    s <- getContents
    let tokens = (alexScanTokens s)
    print tokens
    let parseTree = csvql tokens
    putStrLn ("parseTree: " ++ show(parseTree))
    f <- evaluate parseTree
    putStrLn ("query result: " ++ f)
    putStrLn "done"

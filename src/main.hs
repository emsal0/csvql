module Main where
import Parser
import Scanner

main = do
    s <- getContents
    print (alexScanTokens s)

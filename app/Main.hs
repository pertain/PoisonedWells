module Main where

import Board

main :: IO ()
main = do
    putStr "Enter board size (integer): "
    input <- getLine
    g <- newStdGen
    let n = (read input :: Int)
    showBoard (newBoard n g)

{-# LANGUAGE OverloadedStrings #-}
module Main where

import System.Environment
--import Control.Concurrent.Async
import Data.Char
--import qualified Data.ByteString as B

{-a [] = return ()
a l  = do 
 x <- head l
 a $ tail l
 w <- wait x
 return ()
s id 
 | id == 1000 = []
 | True = do [async (k [id * 750 .. (succ id) * 750])] ++ (spawnThreads $ succ id)
        
k [] = do return ()
k l  = do 
 B.writeFile (show (head l) ++ '.txt') q
 k $ tail l-}
main = do 
 putStr (quine q)
 --a $ s 0
quine s = s ++ show s
q = "{-# LANGUAGE OverloadedStrings #-}\nmodule Main where\nimport System.Environment\nimport Control.Concurrent.Async\nimport Data.Char\nimport qualified Data.ByteString as B\na [] = return ()\na l  = do\n x <- head l\n a $ tail l\n w <- wait x\n return ()\ns id \n | id == 1000 = []\n | True = do [async (k [id * 750 .. (succ id) * 750])] ++ (spawnThreads $ succ id)\n k [] = do return ()\nk l  = do\n B.writeFile (show (head l) ++ '.txt') q\n k $ tail l\nmain = do\n putStr (quine q)\n a $ s 0\nmain = do\n    putStr (quine q)\n    awaitThreadList $ spawnThreads 0\nquine s = s ++ show s\nq = "
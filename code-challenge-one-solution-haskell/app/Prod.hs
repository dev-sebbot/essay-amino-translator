{-# LANGUAGE OverloadedStrings #-}
module Prod where
import System.Environment
import Control.Concurrent.Async
import qualified Data.ByteString as B
a [] = return ()
a l  = do
 x <- head l
 a $ tail l
 w <- wait x
 return ()
s i
 | i == 50 = []
 | True = do [async (k [i * 15000 .. (i+1) * 15000])] ++ (s $ i+1)
k [] = do return ()
k l  = do
 B.writeFile (show $ head l) (B.append q q)
 k $ tail l
main = do
 a $ s 0
q = "{-# LANGUAGE OverloadedStrings #-}\
\module Prod where\
\import System.Environment\
\import Control.Concurrent.Async\
\import Data.Char\
\import qualified Data.ByteString as B\
\a [] = return ()\
\a l  = do\
\ x <- head l\
\ a $ tail l\
\ w <- wait x\
\ return ()\
\s i\
\ | i == 50 = []\
\ | True = do [async (k [i * 15000 .. (i+1) * 15000])] ++ (s $ i+1)\
\k [] = do return ()\
\k l  = do\
\ B.writeFile (show $ head l) (q ++ show q)\
\ k $ tail l\
\main = do\
\ a $ s 0\
\q =" :: B.ByteString
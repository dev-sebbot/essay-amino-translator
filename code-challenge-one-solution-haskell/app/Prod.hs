{-# LANGUAGE OverloadedStrings #-}
module Prod where
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
 | True = do [async $ k [(i * 15000) .. (i+1 * 15000)]] ++ (s $ i+1)
k [] = do return ()
k l  = do 
 B.writeFile (show $ head l) qu
 k $ tail l
main = do 
 a $ s 0
qu = B.append q q
q = "{-# LANGUAGE OverloadedStrings #-}\
\module Prod where\
\import Control.Concurrent.Async\
\import Data.ByteString.UTF8 as V\
\import qualified Data.ByteString as B\
\a [] = return ()\
\a l  = do \
\ x <- head l\
\ a $ tail l\
\ w <- wait x\
\ return ()\
\s i \
\ | i == 50 = []\
\ | True = do [async $ k [i * 15000 .. i+1 * 15000]] ++ (s $ i+1)\
\k [] = do return ()\
\k l  = do \
\ B.writeFile (show $ head l) qu\
\ k $ tail l\
\main = do \
\ a $ s 0\
\qu = B.append q q\
\q = " :: B.ByteString
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Parallel as P
import Control.Concurrent.Async
import qualified Data.ByteString as B

numFiles        = 750000
threadNum       = 50
filesPerThread  = numFiles `div` threadNum
testText        = "mdiT1UO9B65T2wjVrutGqlAeHMPuvpcZxnTKz2TjjuvufHqT79e2RqKkrM71frXVZ4NVzgP8Dhg0pC9v0mbiyZY6TPhjbZ1i7EvoYoPniUXZPKRXS0kCmPOyuvP8gdpYHxpcOCaYR2RcwxtpfYSyhqwO0VBVAJIZ2LooxLI58us8lrsxvxCKQWGHqyP8iCGbE8UEH2ZrptO633zWRqYjoF5llgBouInFID6ca62uoLvcI9vAlyIK5uAyvjPgjm3mMYbzZfYILhgFXlBGSq5QuPA5VuD2v7UFkjIlv3OWvn3NVP4A4DC9uBz9i4JsnVfv0mK9oP9Lxd7VxAh4GXtmTBTYTG7MBAMno3QQvb9YjwQf4AzalXbrJjUGpQMReDKDrDxyQXIXvZ4AIN12ZV6foXYb6I1hkPBLKO8jH14hGtpvU3hdNqrsJcSKMkxPQXdp6awJ619laRTM8wrxp9T4rpzkPxN7H8SCwV0ZeD0ANleWF4GUkZuZmdiT1UO9B65T2wjVrutGqlAeHMPuvpcZxnTKz2TjjuvufHqT79e2RqKkrM71frXVZ4NVzgP8Dhg0pC9v0mbiyZY6TPhjbZ1i7EvoYoPniUXZPKRXS0kCmPOyuvP8gdpYHxpcOCaYR2RcwxtpfYSyhqwO0VBVAJIZ2LooxLI58us8lrsxvxCKQWGHqyP8iCGbE8UEH2ZrptO633zWRqYjoF5llgBouInFID6ca62uoLvcI9vAlyIK5uAyvjPgjm3mMYbzZfYILhgFXlBGSq5QuPA5VuD2v7UFkjIlv3OWvn3NVP4A4DC9uBz9i4JsnVfv0mK9oP9Lxd7VxAh4GXtmTBTYTG7MBAMno3QQvb9YjwQf4AzalXbrJjUGpQMReDKDrDxyQXIXvZ4AIN12ZV6foXYb6I1hkPBLKO8jH14hGtpvU3hdNqrsJcSKMkxPQXdp6awJ619laRTM8wrxp9T4rpzkPxN7H8SCwV0ZeD0ANleWF4GUkZuZ" :: B.ByteString

main :: IO ()
main = do awaitThreadList $ spawnThreads 0

awaitThreadList :: [IO (Async ())] -> IO ()
awaitThreadList [] = return ()
awaitThreadList l  = do a <- head l
                        awaitThreadList $ tail l
                        w <- wait a
                        return ()

spawnThreads :: Int -> [IO (Async ())]
spawnThreads id
    | id == threadNum = []
    | otherwise = do [async threadTask] ++ (spawnThreads $ succ id)
    where
        threadTask = task [id * filesPerThread .. (succ id) * filesPerThread]

task :: [Int] -> IO ()
task [] = do return ()
task l  = do B.writeFile (show (head l) ++ ".txt") testText
             task $ tail l
main=do mapM_ (flip writeFile $ q ++ show q) (map show [1..10])
q="main=do mapM_ (flip writeFile $ q ++ show q) (map show [1..10])\nq="
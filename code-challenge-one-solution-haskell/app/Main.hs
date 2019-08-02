main=do mapM_ (flip writeFile $ q ++ show q) (map show [1..750000])
q="main=do mapM_ (flip writeFile $ q ++ show q) (map show [1..750000])\nq="

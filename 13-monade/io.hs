import System.Random

ugibaj :: IO ()
ugibaj =
    randomRIO (1, 100) >>= \x ->
    putStrLn "Izmislil sem si število, ugani, kakšno je." >>= \_ ->
    (readLn :: IO Integer) >>= \y ->
    if x == y then
        putStrLn "Bravo!"
    else
        putStrLn $ ("Ne, izmislil sem si " ++ show x)
    
ugibaj2 :: IO ()
ugibaj2 =
    randomRIO (1, 100) >>= \x ->
    putStrLn "Izmislil sem si število, ugani, kakšno je." >>
    loop x
        where
            loop x =
                (readLn :: IO Integer) >>= \y ->
                case compare x y of
                    EQ -> putStrLn "Bravo!"
                    LT -> putStrLn "Ne, moje število je manjše" >> loop x
                    GT -> putStrLn "Ne, moje število je večje" >> loop x

ugibaj3 :: IO ()
ugibaj3 = do
    x <- randomRIO (1, 100)
    putStrLn "Izmislil sem si število, ugani, kakšno je."
    loop x
        where
            loop x = do
                y <- readLn :: IO Integer
                case compare x y of
                    EQ -> putStrLn "Bravo!"
                    LT -> putStrLn "Ne, moje število je manjše" >> loop x
                    GT -> putStrLn "Ne, moje število je večje" >> loop x

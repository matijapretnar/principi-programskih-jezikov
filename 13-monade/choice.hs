type Queen = (Int, Int)

attacks :: Queen -> Queen -> Bool
attacks (r1, c1) (r2, c2) = r1 == r2 || c1 == c2 || abs (c1 - c2) == abs (r1 - r2)

queens :: Int -> [[Queen]]
queens n = aux [] 1 where
    aux :: [Queen] -> Int -> [[Queen]]
    aux placed r
        | r > n = return placed
        | otherwise =
            do
                q <- [(r, c) | c <- [1..n]]
                if all (attacks q) placed then
                    aux (q : placed) (r + 1)
                else
                    []

data Nondet a =
    Return a
    | Fail
    | Choose (Nondet a) (Nondet a)
    deriving Show

instance Functor Nondet where
instance Applicative Nondet where
instance Monad Nondet where
    return = Return

    Return x >>= f = f x
    Fail >>= _ = Fail
    Choose c1 c2 >>= f = Choose (c1 >>= f) (c2 >>= f)

chooseFromList :: [a] -> Nondet a
chooseFromList [] = Fail
chooseFromList [x] = Return x
chooseFromList (x : xs) = Choose (Return x) (chooseFromList xs)

queensNondet :: Int -> Nondet [Queen]
queensNondet n = aux [] 1 where
    aux :: [Queen] -> Int -> Nondet [Queen]
    aux placed r
        | r > n = return placed
        | otherwise =
            do
                c <- chooseFromList [1..n]
                let q = (r, c)
                if any (attacks q) placed then
                    Fail
                else
                    aux (q : placed) (r + 1)

findAll :: Nondet a -> [a]
findAll (Return x) = [x]
findAll Fail = []
findAll (Choose c1 c2) = findAll c1 ++ findAll c2

findFirst :: Nondet a -> Maybe a
findFirst (Return x) = Just x
findFirst Fail = Nothing
findFirst (Choose c1 c2) =
    case findFirst c1 of
        Just x -> Just x
        Nothing -> findFirst c2

findMin :: Ord a => Nondet a -> Maybe a
findMin (Return x) = Just x
findMin Fail = Nothing
findMin (Choose c1 c2) = min (findMin c1) (findMin c2)

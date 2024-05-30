data Output a =
    Out a String
    deriving Show

instance Functor Output where
    fmap f (Out x str) = Out (f x) str

instance Applicative Output where

instance Monad Output where
    return x = Out x ""
    -- (>>=) :: Output a -> (a -> Output b) -> Output b
    (Out x out1) >>= f =
        let (Out y out2) = f x in
        Out y (out1 ++ out2)

izpisi :: String -> Output ()
izpisi s = Out () s

primer1 :: Output Integer
primer1 = 
    izpisi "Hello, " >>= \_ ->
    izpisi "world!" >>= \_ ->
    return 42

primer2 :: Output Integer
primer2 =
    izpisi "Hello, " >>
    izpisi "world!" >>
    return 42

primer3 :: Output Integer
primer3 = do
    izpisi "Hello, "
    izpisi "world!"
    return 42

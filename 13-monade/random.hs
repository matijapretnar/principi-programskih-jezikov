import Data.List (foldl1, sort)
import Control.Monad (ap, liftM)
import System.Random

data Prob a =
    Return a
    | Choose Rational (Prob a) (Prob a)
    deriving Show

instance Functor Prob where
    fmap = liftM

instance Applicative Prob where
    pure = Return
    (<*>) = ap

instance Monad Prob where
    Return x >>= f = f x
    Choose p c1 c2 >>= f = Choose p (c1 >>= f) (c2 >>= f)

uniformlyChoose :: [a] -> Prob a
uniformlyChoose [x] = Return x
uniformlyChoose (x : xs) =
    Choose p (Return x) (uniformlyChoose xs) where
        p = 1 / (toRational $ 1 + length xs)

sumOfTwoDice :: Prob Integer
sumOfTwoDice =
    do
        x1 <- uniformlyChoose [1..6]
        x2 <- uniformlyChoose [1..20]
        return (2 * x1 + x2)

run :: Prob a -> IO a
run (Return x) = return x
run (Choose p c1 c2) =
    do
        q <- randomIO :: IO Float
        if q < fromRational p then run c1 else run c2

expectedValue :: (a -> Rational) -> Prob a -> Rational
expectedValue f (Return x) = f x
expectedValue f (Choose p c1 c2) = p * (expectedValue f c1) + (1 - p) * (expectedValue f c2)

type Dist a = [(a, Rational)]

distribution :: Ord a => Prob a -> Dist a
distribution (Return x) = [(x, 1)]
distribution (Choose p c1 c2) = 
    collect (scale p $ distribution c1) (scale (1 - p) $ distribution c2)
    where
        collect :: Ord a => Dist a -> Dist a -> Dist a
        collect [] dist2 = dist2
        collect dist1 [] = dist1
        collect ((x1, p1) : dist1) ((x2, p2) : dist2)
            | x1 < x2 = (x1, p1) : collect dist1 ((x2, p2) : dist2)
            | x2 < x1 = (x2, p2) : collect dist1 ((x1, p1) : dist2)
            | otherwise = (x1, p1 + p2) : collect dist1 dist2
        scale :: Rational -> Dist a -> Dist a
        scale p dist = [(x, p * q) | (x, q) <- dist]

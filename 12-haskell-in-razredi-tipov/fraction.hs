data Fraction a =
    Frac a a

instance Show a => Show (Fraction a) where
    show (Frac x y) = show x ++ " / " ++ show y

instance Num a => Num (Fraction a) where
    Frac a b + Frac c d = Frac (a * d + c * b) (b * d)
    Frac a b * Frac c d = Frac (a * c) (b * d)
    abs (Frac a b) = Frac (abs a) (abs b)
    signum (Frac a b) = Frac (signum a * signum b) 1
    fromInteger n = Frac (fromInteger n) 1
    negate (Frac a b) = Frac (negate a) b

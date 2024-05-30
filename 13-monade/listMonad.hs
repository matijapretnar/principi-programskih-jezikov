test :: [(Integer, Integer)]
test = do
    x <- [1..10]
    y <- [1..x]
    return (x, y)

pitagora = do
    a <- [1..20]
    b <- [a..20]
    c <- [b..50]
    if c * c == a * a + b * b then
        return (a, b, c)
    else
        []

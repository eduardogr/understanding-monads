
module UnderstandingMonads.Functor.MaybeFunctor where 

ex1 = fmap (+3) (Just 4)
-- Expected output: Just 7

ex2 = fmap (*5) Nothing
-- Expected output: Nothing

ex3 = fmap (++" World!") (Just "Hello")
-- Expected output: Just "Hello World!"

ex4 = fmap (++"neverShown") Nothing
-- Expected output: Nothing

ex5 = fmap (3:) (Just [2,1])
-- Expected output: Just [3,2,1]

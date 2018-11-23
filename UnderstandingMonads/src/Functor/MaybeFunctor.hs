
module UnderstandingMonads.Functor.Maybe where 

ej1 = fmap (+3) (Just 4)

ej2 = fmap (*5) Nothing

ej3 = fmap (++" World!") (Just "Hello")

ej4 = fmap (++"neverShown") Nothing

ej5 = fmap (3:) (Just [2,1])

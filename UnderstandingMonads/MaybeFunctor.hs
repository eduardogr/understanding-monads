{-

  Trabajo: Entendiendo Monads

  Autoress: Pablo Andrés Martinez y Eduardo Garcia Ruiz

-}
module UnderstandingMonads.Functor.Maybe where 

<<<<<<< HEAD
ej1 = fmap (+3) (Just 4)

ej2 = fmap (*5) Nothing

ej3 = fmap (++" World!") (Just "Hello")

ej4 = fmap (++"neverShown") Nothing

ej5 = fmap (3:) (Just [2,1])
=======
ejF1 = fmap (+3) (Just 5)
ejF2 = fmap (+3) Nothing
ejF3 = fmap (++"a") (Just "hol")
>>>>>>> 22d447d3db28de310e085d6ea15f68421aef3963

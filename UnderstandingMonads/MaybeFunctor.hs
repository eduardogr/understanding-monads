{-

  Trabajo: Entendiendo Monads

  Autoress: Pablo Andrés Martinez y Eduardo Garcia Ruiz

-}
module UnderstandingMonads.Functor.Maybe where 

ejF1 = fmap (+3) (Just 5)
ejF2 = fmap (+3) Nothing
ejF3 = fmap (++"a") (Just "hol")

{-

  Trabajo: Entendiendo Monads

  Autoress: Pablo Andrés Martinez y Eduardo Garcia Ruiz

-}
module UnderstandingMonads.Monad.Maybe where 

import Control.Monad

restaUno :: Maybe Int -> Maybe Int
restaUno m = do x <- m
                True <- return (x>0)
                return (x-1)
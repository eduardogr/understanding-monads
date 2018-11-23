{-
  Understanding Monads
  Authors: Pablo Andrés Martinez and Eduardo Garcia Ruiz
-}

module UnderstandingMonads.Monad.Maybe where 

import Control.Monad

restaUno :: Maybe Int -> Maybe Int
restaUno m = do x <- m
                True <- return (x>0)
                return (x-1)
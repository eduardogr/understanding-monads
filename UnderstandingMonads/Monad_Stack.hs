{-

  Trabajo: Entendiendo Monads

  Autoress: Pablo Andrés Martinez y Eduardo Garcia Ruiz

-}
module UnderstandingMonads.Examples.Stack where

import Control.Applicative

-- State Monad
data MS s a = C (s -> (a,s))

instance Monad (MS s) where
  --(>>=) :: MS s a -> (a -> MS s b) -> MS s b
    (>>=) (C c1) fc2 = C (\xs -> let
                            (r,xs') = c1 xs
                            (C c2) = fc2 r
                            in c2 xs')
    
    --return :: a -> MS s a
    return k = C (\xs -> (k,xs))
    
instance Applicative (MS s) where
  --pure :: a -> MS s a
    pure = return
  --(<*>) :: MS s (a -> b) -> MS s a -> MS s b
    (<*>) fs ms = do f <- fs
                     x <- ms
                     return (f x)
                     
instance Functor (MS s) where
  --fmap :: (a -> b) -> MS s a -> MS s b
    fmap f ms = (pure f) <*> ms

-- Runs the computation stored in the MS
run :: MS s a -> (s -> (a,s))
run (C c) = c --Just unwraps the function out of the data type 

-- Gives the state of the MS
get :: MS s s
get = C (\xs -> (xs,xs))

update :: Var -> Z -> While ()
update x v = C (\s -> let s' y 
                            | x == y = v 
                            | otherwise = s y 
                      in ((),s'))

-- Fin de la definicion del State Monad (MS)
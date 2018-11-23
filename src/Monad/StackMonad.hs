
module UnderstandingMonads.Monad.StackMonad where

import Control.Applicative

-- Stack Monad as Monad State --
data MS s a = C (s -> (a,s))
type Stack t a = MS [t] a

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
    
-- Gives the state of the MS
get :: MS s s
get = C (\xs -> (xs,xs))

-- Puts a state into the MS
put :: s -> MS s ()
put xs = C (\_ -> ((),xs))

-- Runs the computation stored in the MS
run :: MS s a -> (s -> (a,s))
run (C c) = c --Just unwraps the function out of the data type 

-- pop, push and length
pop :: Stack t (Maybe t)
pop = C (\xs -> case xs of 
                    [] -> (Nothing,[])
                    x:xs' -> (Just x,xs'))

push :: t -> Stack t ()
push x = C (\xs -> ((),x:xs)) 

stackLength :: Stack t Int
stackLength = C (\xs -> let l = foldr (\_ c -> c+1) 0 xs in (l, xs))

-- Stack usage examples

doblePop :: Stack t (Maybe t)
doblePop = pop >> pop

push2pop :: t -> Stack t (Maybe t)
push2pop x = push x >> pop

clearStack :: Stack t (Maybe t)
clearStack = pop >>= (\r -> case r of 
                              Just _ -> clearStack
                              otherwise -> C (\xs -> (Nothing, xs)))

pushLength :: Stack Int ()
pushLength = do l <- stackLength
                push l

-- Polish Notation implementation

compute :: Char -> Int -> Int -> Int
compute '+' n1 n2 = n1+n2
compute '*' n1 n2 = n1*n2
compute '-' n1 n2 = n1-n2

evalPop :: Either Char Int -> Int -> Stack (Either Char Int) ()
evalPop (Left op) n = push (Left op) >> push (Right n)
evalPop (Right n1) n2 = do Just(Left op) <- pop
                           stackLength >>= (\l -> case l of
                                                    0 -> push (Right (compute op n1 n2))
                                                    otherwise -> do (Just x) <- pop
                                                                    evalPop x (compute op n1 n2))
                                                                
polaca :: [Either Char Int] -> Stack (Either Char Int) ()
polaca ((Left op):exp) = push (Left op) >> polaca exp
polaca ((Right n):exp) = do (Just x) <- pop
                            evalPop x n
                            polaca exp
polaca [] = return ()

{-
  examples
-}

ex1 = run doblePop [1,2,3]
ex2 = run (push2pop "a") ["z"]
ex3 = run clearStack [3,1,5,6,4,7,8]
ex4 = run pushLength [2,3,4,7,9]
ex5 = run (polaca [Left '*', Left '+', Right 5, Right 3, Left '-', Right 1, Right 4]) []
                   
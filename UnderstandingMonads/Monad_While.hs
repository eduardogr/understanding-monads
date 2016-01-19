{-

  Trabajo: Entendiendo Monads

  Autoress: Pablo Andrés Martinez y Eduardo Garcia Ruiz

-}
module UnderstandingMonads.Examples.While where 

import Control.Applicative

-----------------------------------------
-- Definiciones necesarias para el modulo
-----------------------------------------
type  Z      =  Integer
type  T      =  Bool
type  State  =  Var -> Z
type  Var    =  String

data  Aexp  =  N Integer
            |  V Var
            |  Add Aexp Aexp
            |  Mult Aexp Aexp
            |  Sub Aexp Aexp
            deriving (Show, Eq)

data  Bexp  =  TRUE
            |  FALSE
            |  Eq Aexp Aexp
            |  Le Aexp Aexp
            |  Neg Bexp
            |  And Bexp Bexp
            deriving (Show, Eq)

data Update = Var :=>: Z

data  Stm   =  Ass Var Aexp
            |  Skip
            |  Comp Stm Stm
            |  If Bexp Stm Stm
            |  While Bexp Stm
            |  Repeat Stm Bexp
            deriving Show

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

-- Puts a state into the MS
put :: s -> MS s ()
put xs = C (\_ -> ((),xs))

-- Fin de la definicion del State Monad (MS)

{-
  Implementación de lenguaje While usando el MS
  ¡Qué Monada de While !
-}
type While a = MS State a

update :: Var -> Z -> While ()
update x v = C (\s -> let s' y 
                            | x == y = v 
                            | otherwise = s y 
                      in ((),s'))

aValW :: Aexp -> While Z
aValW (N n) = C(\s -> (n,s))
aValW (V var) = C(\s -> (s var,s))
aValW (Add a1 a2) = (+) <$> aValW a1 <*> aValW a2
aValW (Mult a1 a2) = (*) <$> aValW a1 <*> aValW a2
aValW (Sub a1 a2) = (-) <$> aValW a1 <*> aValW a2

bValW :: Bexp -> While T
bValW TRUE = C(\s -> (True,s))
bValW FALSE = C(\s -> (False,s))
bValW (Eq a1 a2) = (==) <$> aValW a1 <*> aValW a2
bValW (Le a1 a2) = (<=) <$> aValW a1 <*> aValW a2
bValW (Neg bexp) = (not) <$> bValW bexp
bValW (And b1 b2) = (&&) <$> bValW b1 <*> bValW b2

-- Sentencias del lenguaje While
assW :: Var -> Aexp -> While ()
assW x a = aValW a >>= (\n -> update x n)

skipW :: While ()
skipW = return ()

compW :: While () -> While () -> While ()
compW = (>>)

ifW :: Bexp -> While () -> While () -> While ()
ifW bexp ws1 ws2 = bValW bexp >>= (\b -> if b then ws1 else ws2)

whileW :: Bexp -> While () -> While ()
whileW bexp ws = bValW bexp >>= (\b -> if b then ws >> whileW bexp ws else skipW)

-- Ejecutar código del lenguaje while
runProgram :: While () -> State -> State
runProgram ws s = s'
    where
        (_,s') = run ws s


{-
  TESTING MODULE
-}

sInit :: State
sInit "x" =  10
sInit _   =  0

factorial = do assW "y" (N 1)
               whileW (Neg (Eq (V "x") (N 1))) ( do assW "y" (Mult (V "x") (V "y"))
                                                    assW "x" (Sub (V "x") (N 1))
                                                  )
ejemploRun = runProgram factorial sInit "y"

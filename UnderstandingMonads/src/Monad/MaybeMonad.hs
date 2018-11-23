
module UnderstandingMonads.Monad.Maybe where 

import Control.Monad

substractOne :: Maybe Int -> Maybe Int
substractOne m = do x <- m
                True <- return (x>0)
                return (x - 1)

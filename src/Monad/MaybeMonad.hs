
module UnderstandingMonads.Monad.Maybe where 

import Control.Monad

substractOne :: Maybe Int -> Maybe Int
substractOne m = do x <- m
                    True <- return (x > 0)
                    return (x - 1)

ex1 = substractOne (Just 3)
-- Expected output: Just 2

ex2 = substractOne (Just 0)
-- Expected output: Nothing
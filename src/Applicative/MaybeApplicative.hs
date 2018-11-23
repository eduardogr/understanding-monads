
module UnderstandingMonads.Applicative.MaybeApplicative where

import Control.Applicative

ex1 = Just (*) <*> Just 4 <*> Just 2
-- Expected output: Just 8

ex2 = pure (*) <*> Just 4 <*> Just 2
-- Expected output: Just 8

ex3 = (*) <$> Just 4 <*> Just 2
-- Expected output: Just 8

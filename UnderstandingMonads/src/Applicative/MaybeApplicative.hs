
module UnderstandingMonads.Applicative.Maybe where

import Control.Applicative

-- Ejemplos <*>
ej1 = Just (*) <*> Just 4 <*> Just 2

ej2 = pure (*) <*> Just 4 <*> Just 2

ej3 = (*) <$> Just 4 <*> Just 2

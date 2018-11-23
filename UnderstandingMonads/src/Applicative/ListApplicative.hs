
module UnderstandingMonads.Applicative.List where 

import Control.Applicative

ej1 = pure (*) <*> [1,2,3] <*> [10,100,1000]
-- Expected output: [10,100,1000,20,200,2000,30,300,3000]

ej2 = [(*0),(+100),(^2)] <*> [1,2,3]
-- Expected output: [0,0,0,101,102,103,1,4,9]

ej3 = [(+),(*)] <*> [1,2] <*> [2,5]
-- Expected output: [3,6,4,7,2,5,4,10]

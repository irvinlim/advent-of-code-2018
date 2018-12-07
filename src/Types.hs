{--
 - Copyright (c) 2018 Irvin Lim
 -
 - This software is released under the MIT License.
 - https://opensource.org/licenses/MIT
-}
module Types where

import qualified Data.Text.Lazy as T

data Challenge a b = Challenge
  { day :: Int
  , level :: Int
  , sParse :: T.Text -> a
  , sSolve :: a -> b
  , sShow :: b -> String
  }

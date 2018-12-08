{--
 - Copyright (c) 2018 Irvin Lim
 -
 - This software is released under the MIT License.
 - https://opensource.org/licenses/MIT
-}
{-# LANGUAGE ExistentialQuantification #-}

module Types where

import Data.Maybe
import qualified Data.Text.Lazy as T
import Data.Typeable

data Challenge = forall a b. (Show b, Typeable b) =>
                             Challenge
  { day :: Int
  , level :: Int
  , sParse :: T.Text -> a
  , sSolve :: a -> b
  }

toString :: (Show a, Typeable a) => a -> String
toString x = fromMaybe (show x) (cast x)

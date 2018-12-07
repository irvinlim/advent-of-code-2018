{--
 - Copyright (c) 2018 Irvin Lim
 -
 - This software is released under the MIT License.
 - https://opensource.org/licenses/MIT
-}
{-# LANGUAGE GADTs #-}

module Types where

import qualified Data.Text.Lazy as T

data Challenge where
  Challenge
    :: { day :: Int
       , level :: Int
       , sParse :: T.Text -> a
       , sSolve :: a -> b
       , sShow :: b -> String}
    -> Challenge

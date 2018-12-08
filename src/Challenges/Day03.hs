{--
 - Copyright (c) 2018 Irvin Lim
 -
 - This software is released under the MIT License.
 - https://opensource.org/licenses/MIT
-}
module Challenges.Day03 where

import qualified Data.Text.Lazy as T
import Data.Text.Lazy.Read
import Text.Parsec
import Text.ParserCombinators.Parsec.Combinator

import Types
import Utils.Parsing

data Claim = Claim
  { claimId :: Int
  , origin :: (Int, Int)
  , size :: (Int, Int)
  } deriving (Show)

level1 :: Challenge
level1 =
  Challenge
    { day = 3
    , level = 1
    , sParse = maybeParse (sepEndBy1 claimParser eol)
    , sSolve =
        let f x = "TBI"
         in f
    }

claimParser :: SParsec Claim
claimParser = do
  char '#'
  claimId <- number
  space
  char '@'
  space
  origin <- joinedBy number (char ',')
  char ':'
  space
  size <- joinedBy number (char ',')
  return (Claim claimId origin size)

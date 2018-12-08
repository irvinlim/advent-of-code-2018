{--
 - Copyright (c) 2018 Irvin Lim
 -
 - This software is released under the MIT License.
 - https://opensource.org/licenses/MIT
-}
module Challenges.Day03
  ( level1
  ) where

import qualified Data.Map as M
import qualified Data.Text.Lazy as T
import Data.Text.Lazy.Read
import Text.Parsec
import Text.ParserCombinators.Parsec.Combinator
import Text.Printf

import Types
import Utils.Parsing

data Claim = Claim
  { claimId :: Int
  , origin :: (Int, Int)
  , size :: (Int, Int)
  }

instance Show Claim where
  show Claim { claimId = claimId
             , origin = (originX, originY)
             , size = (sizeX, sizeY)
             } = printf "#%d @ %d,%d: %dx%d" claimId originX originY sizeX sizeY

level1 :: Challenge
level1 =
  Challenge
    { day = 3
    , level = 1
    , sParse = maybeParse (sepEndBy1 claimParser eol)
    , sSolve =
        let fill m pt =
              if pt `M.member` m
                then M.adjust (+ 1) pt m
                else M.insert pt 1 m
            aux m Claim {origin = (ox, oy), size = (sx, sy)} =
              foldl
                fill
                m
                [(x, y) | x <- [ox .. ox + sx - 1], y <- [oy .. oy + sy - 1]]
            filled = foldl aux M.empty
         in M.size . M.filter (> 1) . filled
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
  size <- joinedBy number (char 'x')
  return (Claim claimId origin size)

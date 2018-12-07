{--
 - Copyright (c) 2018 Irvin Lim
 -
 - This software is released under the MIT License.
 - https://opensource.org/licenses/MIT
-}
module ChallengeMux where

import Data.Dynamic
import Data.Map as M
import qualified Data.Text.Lazy as T

import Types

import Challenges.Day1 as D1

runChallenge :: String -> String -> T.Text -> String
runChallenge day level input =
  let challenge = getChallenge day level
      parsed = sParse challenge input
      output = sSolve challenge parsed
      result = sShow challenge output
   in result

dummyChallenge =
  Challenge {day = 0, level = 0, sParse = T.unpack, sSolve = id, sShow = id}

allChallenges = [[dummyChallenge], [D1.level1, D1.level2]]

getChallenge day level =
  let dayIndex = (read day :: Int)
      lvlIndex = (read level :: Int) - 1
   in (allChallenges !! dayIndex) !! lvlIndex

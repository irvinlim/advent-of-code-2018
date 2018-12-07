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

import Challenges.Day01 as D1
import Challenges.Day02 as D2

runChallenge :: String -> String -> T.Text -> String
runChallenge day level =
  let chall = getChallenge day level
   in solveChallenge chall

solveChallenge :: Challenge -> T.Text -> String
solveChallenge Challenge {sParse = parse, sSolve = solve} = show . solve . parse

allChallenges :: [[Challenge]]
allChallenges = [[D1.level1, D1.level2], [D2.level1]]

getChallenge :: String -> String -> Challenge
getChallenge day level =
  let dayIndex = (read day :: Int) - 1
      lvlIndex = (read level :: Int) - 1
   in (allChallenges !! dayIndex) !! lvlIndex

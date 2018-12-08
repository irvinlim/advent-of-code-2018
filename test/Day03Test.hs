{--
 - Copyright (c) 2018 Irvin Lim
 -
 - This software is released under the MIT License.
 - https://opensource.org/licenses/MIT
-}
module Day03Test
  ( tests
  ) where

import Test.HUnit

import Challenges.Day03
import TestUtils

level1TestCases :: [(String, [String], Int)]
level1TestCases =
  [ ("Single claim should be 0", ["#1 @ 1,3: 4x4"], 0)
  , ("Non-overlapping should be 0", ["#1 @ 1,3: 4x4", "#2 @ 6,8: 4x4"], 0)
  , ("Completely overlapping claims", ["#1 @ 1,3: 4x4", "#2 @ 1,3: 4x4"], 16)
  , ("Partially overlapping claims", ["#1 @ 0,0: 2x2", "#2 @ 1,1: 2x2"], 1)
  , ("Given test case", ["#1 @ 1,3: 4x4", "#2 @ 3,1: 4x4", "#3 @ 5,5: 2x2"], 4)
  ]

level1Tests =
  TestLabel "Level 1" $
  TestList (map (makeTestWithLines level1) level1TestCases)

tests = TestLabel "Day 3" $ TestList [level1Tests]

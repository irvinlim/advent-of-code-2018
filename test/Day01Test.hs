{--
 - Copyright (c) 2018 Irvin Lim
 -
 - This software is released under the MIT License.
 - https://opensource.org/licenses/MIT
-}
module Day01Test
  ( tests
  ) where

import Test.HUnit

import Challenges.Day01
import TestUtils

level1TestCases :: [(String, [String], Int)]
level1TestCases =
  [ ("Empty array should return 0", [], 0)
  , ("Positive number should return the number", ["+1"], 1)
  , ("Negative number should return the number", ["-1"], -1)
  , ("Positive numbers should sum correctly", ["+1", "+2"], 3)
  , ("Negative numbers should sum correctly", ["-1", "-2"], -3)
  , ("Mix of integers", ["-132", "+19827", "+8212"], 27907)
  ]

level1Tests =
  TestLabel "Level 1" $
  TestList (map (makeTestWithLines level1) level1TestCases)

level2TestCases :: [(String, [String], Int)]
level2TestCases =
  [ ("Given test case 1", ["+1", "-2", "+3", "+1"], 2)
  , ("Given test case 2", ["+1", "-1"], 0)
  , ("Given test case 3", ["+3", "+3", "+4", "-2", "-4"], 10)
  , ("Given test case 4", ["-6", "+3", "+8", "+5", "-6"], 5)
  , ("Given test case 5", ["+7", "+7", "-2", "-7", "-4"], 14)
  ]

level2Tests =
  TestLabel "Level 2" $
  TestList (map (makeTestWithLines level2) level2TestCases)

tests = TestLabel "Day 1" $ TestList [level1Tests, level2Tests]

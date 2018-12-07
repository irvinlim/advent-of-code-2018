{--
 - Copyright (c) 2018 Irvin Lim
 -
 - This software is released under the MIT License.
 - https://opensource.org/licenses/MIT
-}
module Day1Test where

import Control.Exception
import Test.HUnit
import TestUtils

import Day1

level1Tests =
  TestLabel "Level 1" $
  TestList
    [ TestCase $
      assertEqual "Empty array should return 0" 0 $ level1 ([] :: [String])
    , TestCase $
      assertEqual "Positive number should return the number" 1 $ level1 ["+1"]
    , TestCase $
      assertEqual "Negative number should return the number" (-1) $
      level1 ["-1"]
    , TestCase $
      assertEqual "Positive numbers should sum correctly" 3 $
      level1 ["+1", "+2"]
    , TestCase $
      assertEqual "Negative numbers should sum correctly" (-3) $
      level1 ["-1", "-2"]
    , TestCase $
      assertEqual "Mix of integers" 27907 $ level1 ["-132", "+19827", "+8212"]
    ]

level2Tests =
  TestLabel "Level 2" $
  TestList
    [ TestLabel "Given test case 1" $
      TestCase $ assertEqual "" 2 $ level2 ["+1", "-2", "+3", "+1"]
    , TestLabel "Given test case 2" $
      TestCase $ assertEqual "" 0 $ level2 ["+1", "-1"]
    , TestLabel "Given test case 3" $
      TestCase $ assertEqual "" 10 $ level2 ["+3", "+3", "+4", "-2", "-4"]
    , TestLabel "Given test case 4" $
      TestCase $ assertEqual "" 5 $ level2 ["-6", "+3", "+8", "+5", "-6"]
    , TestLabel "Given test case 5" $
      TestCase $ assertEqual "" 14 $ level2 ["+7", "+7", "-2", "-7", "-4"]
    ]

tests = TestLabel "Day 1" $ TestList [level1Tests, level2Tests]

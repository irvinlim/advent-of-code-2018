{--
 - Copyright (c) 2018 Irvin Lim
 -
 - This software is released under the MIT License.
 - https://opensource.org/licenses/MIT
-}
module Day02Test
  ( tests
  ) where

import Test.HUnit

import Challenges.Day02
import TestUtils

level1TestCases :: [(String, [String], Int)]
level1TestCases =
  [ ("Empty array should return 0", [], 0)
  , ("Non-repeating letters should return 0", ["abcde"], 0)
  , ("Two same letters w/o three same letters should be 0", ["aa"], 0)
  , ("Two same letters w/o three same letters should be 0", ["aa", "bb"], 0)
  , ("Three same letters w/o two same letters should be 0", ["aaa"], 0)
  , ("Three same letters w/o two same letters should be 0", ["aaa", "bbb"], 0)
  , ("Two same letters should be counted", ["aa", "bbb"], 1)
  , ("Three same letters should be counted", ["aaa", "bb"], 1)
  , ("Two/three same letters should be counted", ["aabbb"], 1)
  , ( "Two same letters in same word should not be double counted"
    , ["aabbbcc"]
    , 1)
  , ( "Three same letters in same word should not be double counted"
    , ["aabbbccc"]
    , 1)
  , ("Larger product", ["aabbb", "cccdd", "ee"], 6)
  ]

level1Tests =
  TestLabel "Level 1" $
  TestList (map (makeTestWithLines level1) level1TestCases)

level2TestCases :: [(String, [String], String)]
level2TestCases =
  [ ("Pair of length 2 words returns correct difference", ["ab", "ac"], "a")
  , ("Difference is correct when at front", ["ba", "ca"], "a")
  , ("List of 3 words", ["de", "ab", "ac"], "a")
  , ("Difference is longer", ["abcd", "abce", "bcef"], "abc")
  , ( "Given test case"
    , ["abcde", "fghij", "klmno", "pqrst", "fguij", "axcye", "wvxyz"]
    , "fgij")
  ]

level2Tests =
  TestLabel "Level 2" $
  TestList (map (makeTestWithLines level2) level2TestCases)

tests = TestLabel "Day 2" $ TestList [level1Tests, level2Tests]

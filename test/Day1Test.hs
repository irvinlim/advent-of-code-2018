module Day1Test where

import Control.Exception
import Test.HUnit
import TestUtils

import Day1

tests =
  TestList
    [ TestCase $
      assertEqual "Empty array should return 0" 0 $ sumFreqs ([] :: [String])
    , TestCase $
      assertEqual "Positive number should return the number" 1 $ sumFreqs ["+1"]
    , TestCase $
      assertEqual "Negative number should return the number" (-1) $
      sumFreqs ["-1"]
    , TestCase $
      assertEqual "Positive numbers should sum correctly" 3 $
      sumFreqs ["+1", "+2"]
    , TestCase $
      assertEqual "Negative numbers should sum correctly" (-3) $
      sumFreqs ["-1", "-2"]
    , TestCase $
      assertEqual "Mix of integers" 27907 $ sumFreqs ["-132", "+19827", "+8212"]
    ]

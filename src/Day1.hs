module Day1 where

import qualified Data.Set as S
import qualified Data.Text.Lazy as T
import Data.Text.Lazy.Read

import Debug.Trace

run :: String -> T.Text -> String
run level input =
  let lines = T.lines input
      result = func $ map T.unpack lines
      func
        | level == "1" = level1
        | level == "2" = level2
   in show result

level1 :: [String] -> Int
level1 = sum . parseFreqs

level2 :: [String] -> Int
level2 freqs =
  let f freq s (x:xs) =
        if (freq + x) `S.member` s
          then freq + x
          else f (freq + x) (S.insert (freq + x) s) xs
   in f 0 (S.singleton 0) (cycle (parseFreqs freqs))

parseFreqs :: [String] -> [Int]
parseFreqs = map parseFreq

parseFreq :: String -> Int
parseFreq =
  let f x =
        if head x == '+'
          then tail x
          else x
   in read . f :: String -> Int

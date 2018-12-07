{--
 - Copyright (c) 2018 Irvin Lim
 -
 - This software is released under the MIT License.
 - https://opensource.org/licenses/MIT
-}
module Challenges.Day1 where

import qualified Data.Set as S
import qualified Data.Text.Lazy as T
import Data.Text.Lazy.Read

import Types

level1 :: Challenge
level1 =
  Challenge
    { day = 1
    , level = 1
    , sParse = map T.unpack . T.lines
    , sSolve = sum . parseFreqs
    , sShow = show
    }

level2 :: Challenge
level2 =
  Challenge
    { day = 1
    , level = 2
    , sParse = map T.unpack . T.lines
    , sSolve =
        \freqs ->
          let f freq s (x:xs) =
                if (freq + x) `S.member` s
                  then freq + x
                  else f (freq + x) (S.insert (freq + x) s) xs
           in f 0 (S.singleton 0) ((cycle . parseFreqs) freqs)
    , sShow = show
    }

parseFreqs :: [String] -> [Int]
parseFreqs = map parseFreq

parseFreq :: String -> Int
parseFreq =
  let f x =
        if head x == '+'
          then tail x
          else x
   in read . f :: String -> Int

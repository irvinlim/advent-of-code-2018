{--
 - Copyright (c) 2018 Irvin Lim
 -
 - This software is released under the MIT License.
 - https://opensource.org/licenses/MIT
-}
module Challenges.Day01 where

import qualified Data.Set as S
import qualified Data.Text.Lazy as T
import Data.Text.Lazy.Read

import Types

level1 :: Challenge
level1 = Challenge {day = 1, level = 1, sParse = parse, sSolve = sum}

level2 :: Challenge
level2 =
  Challenge
    { day = 1
    , level = 2
    , sParse = cycle . parse
    , sSolve =
        let f freq s (x:xs) =
              if (freq + x) `S.member` s
                then freq + x
                else f (freq + x) (S.insert (freq + x) s) xs
         in f 0 (S.singleton 0)
    }

parse :: T.Text -> [Int]
parse = map (parseFreq . T.unpack) . T.lines

parseFreq :: String -> Int
parseFreq =
  let f x =
        if head x == '+'
          then tail x
          else x
   in read . f :: String -> Int

{--
 - Copyright (c) 2018 Irvin Lim
 -
 - This software is released under the MIT License.
 - https://opensource.org/licenses/MIT
-}
module Challenges.Day02
  ( level1
  , level2
  ) where

import qualified Data.Map as M
import qualified Data.Text.Lazy as T
import Data.Text.Lazy.Read

import Types

level1 :: Challenge
level1 =
  Challenge
    { day = 2
    , level = 1
    , sParse = parse
    , sSolve =
        let f (i2, i3) word = (i2 + i2', i3 + i3')
              where
                i2' = hasOccurrenceCount 2 (occurrences word)
                i3' = hasOccurrenceCount 3 (occurrences word)
            checksum (i2, i3) = i2 * i3
         in checksum . foldl f (0, 0)
    }

level2 :: Challenge
level2 =
  Challenge
    { day = 2
    , level = 2
    , sParse = parse
    , sSolve =
        \words ->
          let correct =
                [ sameCharacters xs ys
                | xs <- words
                , ys <- words
                , xs /= ys
                , length (sameCharacters xs ys) == length (head words) - 1
                ]
           in head correct
    }

sameCharacters :: String -> String -> String
sameCharacters [] _ = ""
sameCharacters _ [] = ""
sameCharacters (x:xs) (y:ys)
  | x == y = x : sameCharacters xs ys
  | otherwise = sameCharacters xs ys

parse :: T.Text -> [String]
parse = map T.unpack . T.lines

hasOccurrenceCount :: Int -> M.Map Char Int -> Int
hasOccurrenceCount x = min 1 . length . M.filter (== x)

occurrences :: String -> M.Map Char Int
occurrences =
  let aux map x = M.adjust (+ 1) x map
   in foldl aux (M.fromList [(x, 0) | x <- ['a' .. 'z']])

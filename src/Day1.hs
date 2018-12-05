module Day1 where

import qualified Data.Text.Lazy as T
import Data.Text.Lazy.Read

run :: T.Text -> T.Text
run input =
  let lines = T.lines input
      result = sumFreqs $ map T.unpack lines
   in T.pack (show result)

sumFreqs :: [String] -> Int
sumFreqs freqs =
  let f x
        | head x == '+' = tail x
        | otherwise = x
   in sum (map (read . f :: String -> Int) freqs)

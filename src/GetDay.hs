module GetDay where

import Data.Map
import qualified Data.Text.Lazy as T

import Day1

runDay :: String -> String -> T.Text -> String
runDay day level input =
  let func = getFunc day level
   in func input

getFunc :: String -> String -> (T.Text -> String)
getFunc day =
  let funcs = [Day1.run]
      dayIndex = (read day :: Int) - 1
   in funcs !! dayIndex

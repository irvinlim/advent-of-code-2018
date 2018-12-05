module GetDay where

import Data.Map
import qualified Data.Text.Lazy as T

import Day1

runDay :: String -> T.Text -> String
runDay day input =
  let func = getDay day
   in func input

getDay :: String -> (T.Text -> String)
getDay day =
  let days = fromList [("1", Day1.run)]
   in days ! day

{--
 - Copyright (c) 2018 Irvin Lim
 -
 - This software is released under the MIT License.
 - https://opensource.org/licenses/MIT
-}
module Utils.Parsing where

import qualified Data.Text.Lazy as T
import Text.Parsec

type SParsec = Parsec T.Text ()

maybeParse :: SParsec a -> T.Text -> a
maybeParse parser input =
  case parse parser "" input of
    Left e -> error (show e)
    Right parsed -> parsed

eol :: SParsec Char
eol = char '\n'

number :: SParsec Int
number = do
  digits <- many1 digit
  return (read digits :: Int)

joinedBy :: SParsec a -> SParsec b -> SParsec (a, a)
joinedBy parser sep = do
  l <- parser
  sep
  r <- parser
  return (l, r)

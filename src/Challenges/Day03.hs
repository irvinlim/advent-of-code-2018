{--
 - Copyright (c) 2018 Irvin Lim
 -
 - This software is released under the MIT License.
 - https://opensource.org/licenses/MIT
-}
module Challenges.Day03 where

import qualified Data.Map as M
import qualified Data.Set as S
import qualified Data.Text.Lazy as T
import Text.Parsec (char, parse, space)
import Text.ParserCombinators.Parsec.Combinator (sepEndBy1)
import Text.Printf (printf)

import Types
import Utils.Parsing

type Point = (Int, Int)

type ClaimID = Int

type ClaimMap = M.Map Point [ClaimID]

type ClaimIDSet = S.Set ClaimID

data Claim = Claim
  { claimId :: Int
  , origin :: Point
  , size :: Point
  }

instance Show Claim where
  show Claim { claimId = claimId
             , origin = (originX, originY)
             , size = (sizeX, sizeY)
             } = printf "#%d @ %d,%d: %dx%d" claimId originX originY sizeX sizeY

level1 :: Challenge
level1 =
  Challenge
    { day = 3
    , level = 1
    , sParse = parseClaims
    , sSolve =
        let fillGrid = foldl (foldGrid fill) M.empty
            pred xs = length xs > 1
         in M.size . M.filter pred . fillGrid
    }

level2 :: Challenge
level2 =
  Challenge
    { day = 3
    , level = 2
    , sParse = parseClaims
    , sSolve =
        \grids ->
          let claimIds = S.fromList (map claimId grids)
              fillGrid = foldl (foldGrid fill') (M.empty, claimIds)
              pred xs = length xs == 1
           in head $ S.elems $ snd $ fillGrid grids
    }

foldGrid :: (b -> (Point, ClaimID) -> b) -> b -> Claim -> b
foldGrid f initial Claim {claimId = i, origin = (ox, oy), size = (sx, sy)} =
  foldl
    f
    initial
    [((x, y), i) | x <- [ox .. ox + sx - 1], y <- [oy .. oy + sy - 1]]

fill :: ClaimMap -> (Point, ClaimID) -> ClaimMap
fill m (pt, claimId) =
  if pt `M.member` m
    then M.adjust (claimId :) pt m
    else M.insert pt [claimId] m

fill' :: (ClaimMap, ClaimIDSet) -> (Point, ClaimID) -> (ClaimMap, ClaimIDSet)
fill' (m, s) (pt, claimId) =
  if pt `M.member` m
    -- Remove all claims from Set if it is occupied
    then let newClaims = (claimId : (M.!) m pt)
          in (M.adjust (claimId :) pt m, foldl (flip S.delete) s newClaims)
    else (M.insert pt [claimId] m, s)

parseClaims :: T.Text -> [Claim]
parseClaims = maybeParse (sepEndBy1 claimParser eol)

claimParser :: SParsec Claim
claimParser = do
  char '#'
  claimId <- number
  space
  char '@'
  space
  origin <- joinedBy number (char ',')
  char ':'
  space
  size <- joinedBy number (char 'x')
  return (Claim claimId origin size)

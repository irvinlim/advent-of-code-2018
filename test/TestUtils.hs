{--
 - Copyright (c) 2018 Irvin Lim
 -
 - This software is released under the MIT License.
 - https://opensource.org/licenses/MIT
-}
module TestUtils where

import Control.Exception
import Control.Monad
import Data.List
import qualified Data.Text.Lazy as T
import Data.Typeable
import GHC.Natural
import Test.HUnit

import ChallengeMux
import Types

-- See https://stackoverflow.com/a/6147930/2037090
assertException :: (Exception e, Eq e) => e -> IO a -> IO ()
assertException ex action =
  handleJust isWanted (const $ return ()) $ do
    action
    assertFailure $ "Expected exception: " ++ show ex
  where
    isWanted = guard . (== ex)

makeTest :: (Show a, Typeable a) => Challenge -> (String, String, a) -> Test
makeTest chall (name, input, expected) =
  let exp = toString expected
      inp = T.pack input
      res = solveChallenge chall inp
   in TestLabel name $ TestCase $ assertEqual name exp res

makeTestWithLines ::
     (Show a, Typeable a) => Challenge -> (String, [String], a) -> Test
makeTestWithLines chall (name, input, expected) =
  makeTest chall (name, intercalate "\n" input, expected)

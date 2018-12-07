{--
 - Copyright (c) 2018 Irvin Lim
 -
 - This software is released under the MIT License.
 - https://opensource.org/licenses/MIT
-}
module TestUtils where

import Control.Exception
import Control.Monad
import GHC.Natural
import Test.HUnit

-- See https://stackoverflow.com/a/6147930/2037090
assertException :: (Exception e, Eq e) => e -> IO a -> IO ()
assertException ex action =
  handleJust isWanted (const $ return ()) $ do
    action
    assertFailure $ "Expected exception: " ++ show ex
  where
    isWanted = guard . (== ex)

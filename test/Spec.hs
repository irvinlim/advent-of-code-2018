{--
 - Copyright (c) 2018 Irvin Lim
 -
 - This software is released under the MIT License.
 - https://opensource.org/licenses/MIT
-}
import System.Exit
import Test.HUnit

import Day01Test
import Day02Test
import Day03Test

allTests = TestList [Day01Test.tests, Day02Test.tests, Day03Test.tests]

main :: IO ()
main = do
  cs@(Counts _ _ errs fails) <- runTestTT allTests
  putStrLn (showCounts cs)
  if errs > 0 || fails > 0
    then exitFailure
    else exitSuccess

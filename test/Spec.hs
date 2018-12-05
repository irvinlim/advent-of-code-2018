import Day1Test
import System.Exit
import Test.HUnit

allTests = TestList [TestLabel "Day 01" Day1Test.tests]

main :: IO ()
main = do
  cs@(Counts _ _ errs fails) <- runTestTT allTests
  putStrLn (showCounts cs)
  if errs > 0 || fails > 0
    then exitFailure
    else exitSuccess

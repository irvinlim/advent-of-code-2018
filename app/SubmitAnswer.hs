{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.ByteString.Char8 (pack)
import qualified Data.ByteString.Lazy.Char8 as BS
import Data.Char (isSpace)
import qualified Data.Text.Lazy as T
import Data.Text.Lazy.Encoding
import qualified Data.Text.Lazy.IO as TIO
import Network.HTTP.Client
import Network.HTTP.Client.TLS
import System.IO

import GetDay

main :: IO ()
main = do
  putStrLn "\n === Advent of Code 2018 === \n"
  day <- promptLine "Which day would you like to submit? "
  level <- promptLine "Which level would you like to submit? "
  sessionId <- getSession
  putStrLn ("Getting input for Day " ++ day ++ "...")
  let inputUrl = "https://adventofcode.com/2018/day/" ++ day ++ "/input"
  res <- sendReq inputUrl sessionId ""
  let input = decodeUtf8 (responseBody res)
  putStrLn ("Running Day" ++ day ++ "...")
  let output = GetDay.runDay day input
  putStrLn ("Result: " ++ output)
  putStrLn ""
  putStrLn "Submitting answer..."
  let submitUrl = "https://adventofcode.com/2018/day/" ++ day ++ "/answer"
  res <- sendReq submitUrl sessionId ("level=" ++ level ++ "&answer=" ++ output)
  let resBody = decodeUtf8 (responseBody res)
  let resText = findWrapped ("<article><p>", "</p></article>") resBody
  TIO.putStrLn resText

findWrapped :: (String, String) -> T.Text -> T.Text
findWrapped (left, right) text =
  let end = snd $ T.breakOnEnd (T.pack left) text
      start = fst $ T.breakOn (T.pack right) end
   in start

promptLine :: String -> IO String
promptLine prompt = do
  putStr prompt
  hFlush stdout
  getLine

getSession :: IO String
getSession = do
  sessionId <- readFile ".session"
  stripSpace sessionId

sendReq :: String -> String -> String -> IO (Response BS.ByteString)
sendReq url sessionId body = do
  manager <- newManager tlsManagerSettings
  initialRequest <- parseRequest url
  let request =
        initialRequest
          { method = "POST"
          , requestHeaders =
              [ ("Cookie", pack $ "session=" ++ sessionId)
              , ("Content-Type", pack "application/x-www-form-urlencoded")
              ]
          , requestBody = RequestBodyBS $ pack body
          }
  httpLbs request manager

stripSpace :: String -> IO String
stripSpace =
  let strip = (reverse . dropWhile isSpace . reverse . dropWhile isSpace)
   in return . strip

{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.ByteString.Char8 (pack)
import qualified Data.ByteString.Lazy.Char8 as BS
import Data.Char (isSpace)
import Data.Text.Lazy.Encoding
import qualified Data.Text.Lazy.IO as TIO
import Network.HTTP.Client
import Network.HTTP.Client.TLS
import System.IO

import GetDay

main :: IO ()
main = do
  putStrLn "\n === Advent of Code 2018 === \n"
  day <- promptDay
  sessionId <- getSession
  putStrLn ("Getting input for Day " ++ day ++ "...")
  let inputUrl = "https://adventofcode.com/2018/day/" ++ day ++ "/input"
  res <- sendReq inputUrl sessionId
  let input = decodeUtf8 (responseBody res)
  putStrLn ("Running Day" ++ day ++ "...")
  let output = GetDay.runDay day input
  putStrLn "Result:"
  TIO.putStrLn output

promptDay :: IO String
promptDay = do
  putStr "Which day would you like to submit? "
  hFlush stdout
  getLine

getSession :: IO String
getSession = do
  sessionId <- readFile ".session"
  stripSpace sessionId

sendReq :: String -> String -> IO (Response BS.ByteString)
sendReq url sessionId = do
  manager <- newManager tlsManagerSettings
  initialRequest <- parseRequest url
  let request =
        initialRequest
          { method = "POST"
          , requestHeaders = [("Cookie", pack $ "session=" ++ sessionId)]
          }
  httpLbs request manager

stripSpace :: String -> IO String
stripSpace =
  let strip = (reverse . dropWhile isSpace . reverse . dropWhile isSpace)
   in return . strip

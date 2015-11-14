{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import System.Daemon
import Control.Concurrent.MVar ( newMVar )
import Data.Default ( def )
import Types
import Handler

daemonName :: String
daemonName = "lhi"

main :: IO ()
main = do
  st  <- newMVar initState
  cmd <- command
  ensureDaemonRunning daemonName (options cmd) (handler st)
  res <- client cmd
  print res

options :: Command -> DaemonOptions
options cmd = def { daemonPort = port cmd }

client :: Command -> IO (Maybe Response)
client cmd = runClient "localhost" (port cmd) cmd


{-
% dist/build/memo/memo get apples
Daemon started on port 7856
Just (Failed "not found")
% dist/build/memo/memo put apples 23
Just (Value "ok")
% dist/build/memo/memo get apples
Just (Value "23")
-}

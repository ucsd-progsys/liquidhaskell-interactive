{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import System.Daemon
import Control.Concurrent.MVar ( newMVar )
import Data.Default ( def )
import Types
import qualified Handler as H

daemonName :: String
daemonName = "lhi"

main :: IO ()
main = do
  st  <- newMVar H.init
  cmd <- command
  ensureDaemonRunning daemonName (options cmd) (H.handler st)
  res <- client cmd
  print res

options :: Command -> DaemonOptions
options cmd = def { daemonPort = port cmd }

client :: Command -> IO (Maybe Response)
client cmd = runClient "localhost" (port cmd) cmd

{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Concurrent.MVar ( MVar, newMVar, modifyMVar )
import Data.Default ( def )
import Data.Serialize ( Serialize )
import Data.String ( fromString )
import GHC.Generics
import System.Environment ( getArgs )
import System.Daemon

handleCommand :: MVar Book -> Command -> IO Response
handleCommand bookVar comm = modifyMVar bookVar $ \book -> return $
    case comm of
      Get key -> ( book
                 , maybe (Failed "not found") Value (M.lookup key book) )
      Put key value -> ( M.insert key value book
                       , Value "ok" )


main :: IO ()
main = do
    bookVar <- newMVar M.empty
    let options = def { daemonPort = 7856 }
    ensureDaemonRunning "memo" options (handleCommand bookVar)
    args <- getArgs
    let args' = map fromString args
    res <- case args' of
      ["get", key]        -> runClient "localhost"  7856 (Get key)
      ["put", key, value] -> runClient "localhost"  7856 (Put key value)
      _                   -> error "invalid command"
    print (res :: Maybe Response)

{-
main :: IO ()
main = do
    bookVar <- newMVar M.empty
    let options = def { daemonPort = 7856 }
    ensureDaemonRunning "memo" options (handleCommand bookVar)
    args <- getArgs
    let args' = map fromString args
    res <- case args' of
      ["get", key]        -> runClient "localhost"  7856 (Get key)
      ["put", key, value] -> runClient "localhost"  7856 (Put key value)
      _                   -> error "invalid command"
    print (res :: Maybe Response)

-}

{-
% dist/build/memo/memo get apples
Daemon started on port 7856
Just (Failed "not found")
% dist/build/memo/memo put apples 23
Just (Value "ok")
% dist/build/memo/memo get apples
Just (Value "23")
-}

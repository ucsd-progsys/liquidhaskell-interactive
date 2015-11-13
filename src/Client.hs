
module Client (
    getServerStatus
  , stopServer
  , serverCommand
  )
  where

import Daemonize (daemonize)
import Types
import Network (PortID(UnixSocket), connectTo)
import System.IO

connect :: FilePath -> IO Handle
connect sock = do
  connectTo "" (UnixSocket sock)


getServerStatus :: FilePath -> IO ()
getServerStatus sock = do
  h <- connect sock
  hPutStrLn h $ show undefined -- SrvStatus
  hFlush h
  startClientReadLoop h

stopServer :: FilePath -> IO ()
stopServer sock = do
  h <- connect sock
  hPutStrLn h $ show undefined -- SrvExit
  hFlush h
  startClientReadLoop h

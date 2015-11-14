module Handler (handler) where

import Types

import Control.Concurrent.MVar -- ( MVar, modifyMVar, readMVar )
import Data.HashMap.Strict as M

------------------------------------------------------------------------------
handler :: MVar State -> Command -> IO Response
------------------------------------------------------------------------------

handler r (Get k _) = do
    t <- table <$> readMVar r
    return $ maybe err Value $ M.lookup k t
  where
    err = Failed "not found"

handler r (Put k v _) = do
  modifyMVar_ r $ \st -> return st { table = M.insert k v (table st) }
  return      $  Value "Ok!"

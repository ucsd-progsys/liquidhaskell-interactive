module Handler (init, handler) where

import Prelude hiding (init)
import Types
import Control.Concurrent.MVar
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

------------------------------------------------------------------------------
init :: State
------------------------------------------------------------------------------
init = State M.empty

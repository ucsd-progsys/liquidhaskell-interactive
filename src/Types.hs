{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE DeriveDataTypeable #-}

module Types
  (
    -- * Commands
    Command (..)

    -- * Response
  , Response (..)

    -- * State
  , State (..)

    -- * Extract Command
  , command

    -- * Init State
  ) where

-- import Data.ByteString.Char8 ( ByteString )
import Data.Serialize        ( Serialize )
import GHC.Generics
import System.Console.CmdArgs
import qualified Data.HashMap.Strict as M

-------------------------------------------------------------------------------
-- | State --------------------------------------------------------------------
-------------------------------------------------------------------------------

data State = State { table :: M.HashMap String String }

-------------------------------------------------------------------------------
-- | Command ------------------------------------------------------------------
-------------------------------------------------------------------------------

data Command = Put { key  :: String
                   , val  :: String
                   , port :: Int
                   }
             | Get { key  :: String
                   , port :: Int
                   }
               deriving ( Generic, Data, Typeable, Show )

instance Serialize Command

-------------------------------------------------------------------------------
-- | Response -----------------------------------------------------------------
-------------------------------------------------------------------------------

data Response = Failed String
              | Value  String
               deriving ( Generic, Data, Typeable, Show )

instance Serialize Response

---------------------------------------------------------------------------------
-- | Parsing Command Line -------------------------------------------------------
---------------------------------------------------------------------------------
command :: IO Command
-------------------------------------------------------------------------------
command = cmdArgs config

cGet :: Command
cGet = Get { key  = def    &= help "Key to lookup"
           , port = 7856   &= help "Port at which to listen"
           } &= help    "Return value of given key"

cSet :: Command
cSet = Put { key = def     &= help "Key to update"
           , val = def     &= help "New value to update key to"
           , port = 7856   &= help "Port at which to listen"
           } &= help    "Update value of given key"

config :: Command
config = modes [ cGet &= auto
               , cSet
               ]
           &= help    "lhi is an interactive server for LiquidHaskell"
           &= program "lhi"
           &= summary "lhi © Copyright 2015 Regents of the University of California."
           &= verbosity

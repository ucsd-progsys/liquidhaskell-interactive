{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE DeriveDataTypeable #-}

module Types
  (

    -- * Commands
    Command (..)

    -- * Extract Command
  , getCommand
  ) where

import GHC.Generics
import System.Console.CmdArgs

-- import           System.Console.CmdArgs     hiding  (Loud)

-- import System.Console.CmdArgs.Explicit (modeValue)
-- import Control.Monad (foldM)
-- import System.Environment (withArgs)

data Command = Get { key :: String
                   }
             | Set { key :: String
                   , val :: Int
                   }
             deriving (Eq, Data, Typeable, Show, Generic)

---------------------------------------------------------------------------------
-- | Parsing Command Line -------------------------------------------------------
---------------------------------------------------------------------------------
getCommand :: IO Command
-------------------------------------------------------------------------------
getCommand = cmdArgs config

cGet :: Command
cGet = Get { key = def   &= help "Key to lookup"
           } &= help    "Return value of given key"

cSet :: Command
cSet = Set { key = def   &= help "Key to update"
           , val = def   &= help "New value to update key to"
           } &= help    "Update value of given key"

config :: Command
config = modes [ cGet &= auto
               , cSet
               ]
           &= help    "lhi is an interactive server for LiquidHaskell"
           &= program "lhi"
           &= summary "lhi © Copyright 2015 Regents of the University of California."
           &= verbosity

{-# LANGUAGE DerivingVia #-}
{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module Data.Discord.Nickname where

import RIO
import Data.Aeson
import Data.Text qualified as DT

newtype Nickname = Nickname DT.Text
  deriving (Show, Eq)
  deriving (FromJSON) via DT.Text

{-# LANGUAGE DerivingVia #-}
{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module Data.Discord.GuildId where
import RIO

import Data.Aeson
import Data.Text qualified as DT

newtype GuildId = GuildId DT.Text
  deriving (Eq)
  deriving (FromJSON, ToJSON, Show) via DT.Text

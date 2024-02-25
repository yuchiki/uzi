{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}

module EventHandler.ReadyEventHandler where

import Effectful.DiscordGateway (DiscordGateway)
import Effectful.DynamicLogger
import EnvConfig
import Data.Discord.Response
import Effectful
import Data.String.Conversions (ConvertibleStrings(convertString))


readyEventHandler :: (DiscordGateway :> es, DynamicLogger :> es) => EnvConfig -> Response -> Eff es ()
readyEventHandler _ = \case
  Ready r -> do
    info "Dispatch ReadyEventHandler"
    info . convertString . show $ r
  _ -> pure ()

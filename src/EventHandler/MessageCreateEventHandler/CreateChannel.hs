{-# OPTIONS_GHC -Wno-missing-export-lists #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}

module EventHandler.MessageCreateEventHandler.CreateChannel where

import Data.Discord 
import Effectful
import Effectful.NonDet
import Effectful.DynamicLogger
import Control.Lens
import Data.Discord.Response.MessageCreateEventResponse qualified as MCE
import Effectful.DiscordChannel

createChannelEventHandler :: (DiscordChannel :> es, NonDet :> es , DynamicLogger :> es) => Response -> Eff es ()
createChannelEventHandler = \case
  MessageCreate res ->  do
    -- FIXME: create-channel foobar みたいな構文のみ受けれるようにする
    let guildId = res ^. MCE.guildId
    info "CreateChannelEventHandler dispatched"
    createChannel guildId (makeCreateChannelParams . ChannelName $ "test")
    pure ()
  _ -> emptyEff

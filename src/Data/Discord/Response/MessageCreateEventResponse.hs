{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DerivingVia #-}
{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module Data.Discord.Response.MessageCreateEventResponse (
  MessageCreateEventResponse(..),
  ChannelId(..),
  Content(..)
) where

import Data.Text
import Data.Aeson
import Data.Maybe (fromMaybe)
import Data.Discord.Member

newtype ChannelId = ChannelId Text
  deriving (Show, Eq)
  deriving FromJSON via Text

newtype Content = Content Text
  deriving (Show, Eq)
  deriving FromJSON via Text

data MessageCreateEventResponse = MessageCreateEventResponse {
  channelId :: ChannelId,
  content :: Content,
  mentions :: [Member],
  member :: Member,
  isBot :: Bool
}
  deriving (Show, Eq)

instance FromJSON MessageCreateEventResponse where
  parseJSON = withObject "MessageCreateEventResponse" $ \o -> do
    dataSection <- o .: "d"
    channelId <- parseJSON @ChannelId =<< dataSection .: "channel_id"
    content <- parseJSON @Content =<< dataSection .: "content"
    mentions <- parseJSON @[Member] =<< dataSection .: "mentions"
    member <- parseJSON @Member =<< dataSection .: "member"
    author <- dataSection .: "author"
    isBot <-  author .:? "bot"
    pure MessageCreateEventResponse {
      channelId = channelId,
      content = content,
      mentions = mentions,
      member = member,
      isBot = fromMaybe False isBot
    }
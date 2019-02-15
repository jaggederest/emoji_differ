require "emoji_differ/version"
require "emoji_differ/slack_api"

module EmojiDiffer
  class Error < StandardError; end
  
  def self.current_emoji(slack_token)
    EmojiDiffer::SlackApi.new(slack_token).emoji
  end
end

require "emoji_differ/version"
require "emoji_differ/slack_api"
require "emoji_differ/cache"

module EmojiDiffer
  class Error < StandardError; end

  class Differ
    def initialize(slack_token)
      @slack_token = slack_token
    end
    
    # Fetch emojis from Slack
    def slack_emoji
      @slack_emoji ||= EmojiDiffer::SlackApi.new(@slack_token).emoji
    end

    # Fetch emojis from disk
    def cache_emoji
      @cache_emoji ||= cache.load
    end

    # An inefficient way run a diff on the cached vs. Slack emoji 
    def diff
      cache_names = cache_emoji.map { |emoji| emoji.name }
      slack_emoji.map { |emoji| cache_names.include?(emoji.name) }
    end

    def update_cache
      cache(slack_emoji).save
    end

    def cache(list = EmojiDiffer::List.new)
      @cache ||= EmojiDiffer::Cache.new(list)
    end
  end
end

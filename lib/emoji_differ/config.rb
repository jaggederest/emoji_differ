module EmojiDiffer
  class Config
    attr_writer :token, :cache_location

    def initialize
      @token = nil
      @cache_location = nil
    end

    def token
      @token || ENV['SLACK_API_TOKEN'] || File.read('.slack_token')
    end

    def cache_location
      @cache_location || ENV['EMOJI_CACHE_LOCATION'] || 'emoji_cache'
    end
  end
end
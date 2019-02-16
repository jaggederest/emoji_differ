module EmojiDiffer
  class Config
    attr_writer :token, :cache_location

    def initialize
      @token = nil
      @cache_location = nil
    end

    def read_token_file
      @file_token ||= File.exists?('.slack_token') ? File.read('.slack_token') : nil
    end

    def token
      @token || ENV['SLACK_API_TOKEN'] || read_token_file
    end

    def cache_location
      @cache_location || ENV['EMOJI_CACHE_LOCATION'] || 'emoji_cache'
    end
  end
end
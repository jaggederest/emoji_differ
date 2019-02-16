require "net/https"
require "emoji_differ/list"

module EmojiDiffer
  class SlackApi < Struct.new(:token)
    API_ENDPOINT = 'https://slack.com/api/emoji.list'

    def emoji
      EmojiDiffer::List.new.load_json(get_emoji.to_s)
    end

    def api_endpoint
      API_ENDPOINT
    end

    def build_query
      uri = URI(api_endpoint)
      uri.query = URI.encode_www_form({
        token: token,
      })
      uri
    end

    def get_emoji
      handle = Net::HTTP.get_response(build_query)

      if !handle.is_a?(Net::HTTPSuccess)
        raise "Slack API is out of business today, #{handle.inspect}"
      end

      handle.body
    end
  end
end

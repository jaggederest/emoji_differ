require "net/https"
require "emoji_differ/list"

module EmojiDiffer
  class SlackApi < Struct.new(:token)
    API_ENDPOINT = 'https://slack.com/api/emoji.list'

    def raw_response
      Net::HTTP.get_response(uri).tap do |handle|
        if !handle.is_a?(Net::HTTPSuccess)
          raise "Slack API is out of business today, #{handle.inspect}"
        end
      end
    end

    def uri
      URI(API_ENDPOINT).tap do |uri|
        uri.query = URI.encode_www_form({
          token: token,
        })
      end
    end

    def emoji
      EmojiDiffer::List.new(raw_response)
    end
  end
end

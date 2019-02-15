require "net/https"

module EmojiDiffer
  class SlackApi < Struct.new(:token)
    API_ENDPOINT = 'https://slack.com/api/emoji.list'

    def emojis
      uri = URI(API_ENDPOINT)
      uri.query = uri.encode_www_form({
        token: token,
      })

      handle = Net::HTTPS.get_response(uri)

      if !handle.is_a?(Net::HTTPSuccess)
        raise "Slack API is out of business today, #{handle.inspect}"
      end

      EmojiDiffer::List.new(handle.body)
    end
  end
end

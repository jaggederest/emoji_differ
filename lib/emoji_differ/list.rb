require "json"
require "emoji_differ/emoji"

module EmojiDiffer
  # List of emojis loaded from disk cache or from Slack API.
  class List
    attr_reader :emojis

    def initialize
      @emojis = []
    end

    # Load JSON from string
    # Params:
    # +jsonb+:: a valid JSON string
    def load_json(jsonb)
      @emojis = transform(jsonb).map do |emoji| 
        EmojiDiffer::Emoji.new(emoji["name"], emoji["picture_link"])
      end

      self
    end

    def to_s
      @emojis.to_s
    end

    def to_json
      JSON.dump({ emoji: @emojis.map { |emoji| emoji.to_h } })
    end

    def length
      @emojis.length
    end

    # Remove all items from list.
    def clear
      @emojis = []
      self
    end

    private
      # Read JSON
      # Params:
      # +jsonb+:: a valid JSON string
      def transform(jsonb)
        JSON.parse(jsonb)["emoji"]
      end
  end
end

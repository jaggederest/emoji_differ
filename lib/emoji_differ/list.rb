require "json"
require "emoji_differ/emoji"

module EmojiDiffer
  class List
    include Enumerable

    def initialize(jsonb)
      parse(jsonb)
      @emojis = transform(jsonb)
    end

    def to_s
      @emojis.to_s
    end

    def each
      @emojis.each do |emoji|
        yield emoji
      end
    end

    def to_json
      parsed #cheeky eh
    end

    private
      def parse(json)
        @parsed = JSON.parse(jsonb)
      end

      def parsed
        @parsed
      end

      def timestamp
        parsed['cache_ts'].to_f
      end

      def transform(jsonb)
        parsed['emoji'].map { |name, picture_link| EmojiDiffer::Emoji.new(name, picture_link, timestamp) }
      end
  end
end

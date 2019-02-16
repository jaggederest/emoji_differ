require "json"
require "emoji_differ/emoji"

module EmojiDiffer
  class List
    include Enumerable

    def initialize(json)
      @parsed = parse(json)
      @emojis = transform
    end

    def to_s
      @emojis.to_s
    end

    def each
      @emojis.each do |emoji|
        yield emoji
      end
    end

    def length
      @emojis.length
    end

    def to_json
      JSON.generate(parsed) #cheeky eh
    end

    private
      def parse(json)
        JSON.parse(json)
      end

      attr_reader :parsed

      def timestamp
        parsed['cache_ts'].to_f
      end

      def transform
        parsed['emoji'].map { |name, picture_link| EmojiDiffer::Emoji.new(name, picture_link, timestamp) }
      end
  end
end

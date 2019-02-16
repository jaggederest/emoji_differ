require "json"
require "emoji_differ/emoji"

module EmojiDiffer
  class List
    include Enumerable

    def initialize(emoji=nil)
      @emojis = emoji
    end

    def self.from_json(json)
      new.parse(json)
    end

    def to_s
      collection = emojis.map(&:to_s).join(" ")
      "#{collection}\n Total: #{length}"
    end

    def each
      emojis.each do |emoji|
        yield emoji
      end
    end

    def -(other)
      other_names = other.emojis.to_a.map(&:name)
      self.class.new(emojis.reject {|emoji| other_names.include?(emoji.name) })
    end

    def length
      emojis.length
    end

    def to_json
      JSON.generate(parsed) #cheeky eh
    end

    def emojis
      @emojis ||= transform
    end

    def parse(json)
      @parsed = JSON.parse(json)
      self
    end

    private

      attr_reader :parsed

      def timestamp
        parsed['cache_ts'].to_f
      end

      def transform
        parsed['emoji'].map { |name, picture_link| EmojiDiffer::Emoji.new(name, picture_link, timestamp) }
      end
  end
end

require "json"
require "emoji_differ/emoji"

module EmojiDiffer
  class List
    def initialize(jsonb)
      @emojis = transform(jsonb).map { |name, picture_link| EmojiDiffer::Emoji.new(name, picture_link) }
    end

    def to_s
      @emojis.to_s
    end

    def to_json
      raise "Unimplemented"
    end

    private
      def transform(jsonb)
        JSON.parse(jsonb)["emoji"]
      end
  end
end

require "json"

module EmojiDiffer
  class List
    def initialize(jsonb)
      @emojis = transform(jsonb)
    end

    def to_s
      @emojis.to_s
    end

    def to_json
      raise "Unimplemented"
    end

    private
      def transform(jsonb)
        JSON.parse(jsonb)
      end
  end
end

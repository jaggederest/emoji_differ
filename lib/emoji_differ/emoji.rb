require "json"

module EmojiDiffer
  # Represents an emoji
  class Emoji < Struct.new(:name, :picture_link)
    def to_s
      name
    end
  end
end

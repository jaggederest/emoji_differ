module EmojiDiffer
  class Emoji < Struct.new(:name, :picture_link, :timestamp)
    def to_s
      ":#{name}:"
    end
  end
end

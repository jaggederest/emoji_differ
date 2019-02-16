module EmojiDiffer
  class Emoji < Struct.new(:name, :picture_link, :timestamp)
    include Comparable

    def to_s
      ":#{name}:"
    end

    def <=>(other)
      name <=> other.name
    end
  end
end

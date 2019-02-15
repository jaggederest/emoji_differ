require "emoji_differ/version"
require "emoji_differ/list"

module EmojiDiffer
  class Error < StandardError; end
  def self.list
    EmojiDiffer::List.new
  end
end

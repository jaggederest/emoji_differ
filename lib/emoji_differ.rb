require "emoji_differ/version"
require "emoji_differ/slack_api"
require 'emoji_differ/config'

module EmojiDiffer
  class Error < StandardError; end
  def self.config
    @config ||= EmojiDiffer::Config.new
    yield @config
  end

  def self.current_emoji
    EmojiDiffer::SlackApi.new(slack_token).emoji
  end

  def self.new_emoji
    load_emoji.reject {|x| current_emoji.map(&:name).include?(x.name) }
  end

  def self.save_emoji
    File.open(config.cache_location, 'w') do |f|
      f.print EmojiDiffer::SlackApi.new(config.token).to_json
    end
  end

  def self.read_nb_chunk(io)
    io.read_nonblock(8000)
  rescue IO::WaitReadable
    IO.select([io])
    retry
  end

  def self.load_emoji
    File.open(config.cache_location, 'r') do |f|
      contents = ''

      while !f.eof? && (chunk = read_nb_chunk(f))
        contents += chunk
      end
      EmojiDiffer::List.new(contents)
    end
  end
end

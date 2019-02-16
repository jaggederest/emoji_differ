require "emoji_differ/version"
require "emoji_differ/slack_api"
require 'emoji_differ/config'

module EmojiDiffer
  class Error < StandardError; end

  def self.config
    @config ||= EmojiDiffer::Config.new
    if block_given?
      yield @config
    else
      @config
    end
  end

  def self.current
    @current ||= EmojiDiffer::SlackApi.new(config.token).emoji
  end

  def self.cached
    load
  end

  def self.deleted
    load - current
  end

  def self.new_emoji
    current - load
  end

  def self.save
    File.open(config.cache_location, 'w') do |f|
      f.print EmojiDiffer::SlackApi.new(config.token).emoji.to_json
    end
  end

  def self.read_nb_chunk(io)
    io.read_nonblock(8000)
  rescue IO::WaitReadable
    IO.select([io])
    retry
  end

  def self.load
    File.open(config.cache_location, 'r') do |f|
      contents = ''

      while !f.eof? && (chunk = read_nb_chunk(f))
        contents += chunk
      end
      EmojiDiffer::List.from_json(contents)
    end
  end
end

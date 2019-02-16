require "emoji_differ/list"

module EmojiDiffer
  # Disk cache capable of reading and writing from/to disk.
  # Params:
  # +emoji_list+:: responds to #to_json, #load_json
  class Cache < Struct.new(:emoji_list)
    def clear
      write_to_disk(default_cache_value)
    end

    def save
      write_to_disk(emoji_list.to_json)
    end

    def load
      emoji_list.load_json(load_from_disk.to_s)
    end

    private
      def path
        File.join(File.expand_path(File.dirname(__FILE__)), 'cache.db')
      end

      def write_to_disk(data)
        handle = File.new(path, "w")
        handle.write(data)
        handle.close
      end

      def load_from_disk
        if !File.exists?(path)
          default_cache_value
        else
          File.new(path, "r").read
        end
      end

      def default_cache_value
        EmojiDiffer::List.new.to_json
      end
  end
end

require "emoji_differ/cache"

RSpec.describe EmojiDiffer::Cache do
  it "can be initialized" do
    EmojiDiffer::Cache.new
  end

  describe "integration tests" do
    let(:path) { subject.send(:path) }
    let(:cache_json) { '{"emoji": []}' }
    let(:list) do
      double("emoji_list",
        to_json: cache_json,
        load_json: double(length: 5),
        length: 0,
        new: double(
          "clear_emoji_list",
          to_json: cache_json,
        ),
      )
    end

    subject do
      EmojiDiffer::Cache.new(list)
    end

    # Clean up any disk writes
    after do
      begin
        File.delete(path)
      rescue
      end
    end

    context "cache is not on disk yet" do
      it "can write to disk" do
        subject.save

        # Check that it wrote successfully
        expect(File.exists?(path)).to eq(true)
        expect(File.new(path).read).to eq(cache_json)
      end

      fit "can return default cache value" do
        subject.load
        expect(subject.emoji_list.length).to eq(0)
      end
    end

    context "cache already exists on disk" do
      before do
        handle = File.new(path, "w")
        handle.write(cache_json)
        handle.close
      end

      it "can read from disk" do
        list = subject.load
        expect(list.length).to eq(5)
      end
    end
  end
end

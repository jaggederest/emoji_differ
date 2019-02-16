RSpec.describe EmojiDiffer do
  it "has a version number" do
    expect(EmojiDiffer::VERSION).not_to be nil
  end
end


RSpec.describe EmojiDiffer::Differ do
  it "can be initialized" do
    EmojiDiffer::Differ.new("fake_slack_token")
  end

  describe "integration tests" do
    let(:slack_token) { "fake_slack_token" }

    subject do
      EmojiDiffer::Differ.new(slack_token)
    end

    it "can load from cache" do
      subject.cache_emoji
    end

    context "given a list of emojis" do
      before do
        allow(subject).to receive(:slack_emoji).and_return EmojiDiffer::List.new
      end

      it "can write to cache" do
        subject.update_cache
      end
    end
  end
end

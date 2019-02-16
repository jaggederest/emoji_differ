require "emoji_differ/list"

RSpec.describe EmojiDiffer::List do
  it "can be initialized" do
    EmojiDiffer::List.new
  end

  describe "integration tests" do
    let(:json) { '{"emoji": []}' }

    subject do
      EmojiDiffer::List.new
    end

    context "empty json" do
      it "can load it" do
        subject.load_json(json)
      end
    end

    context "json with a an emoji" do
      let(:json) do
        %{
          {"emoji": [
            {"name": "test", "picture_link": "test_link"}
          ]}
        }
      end

      it "can load an emoji" do
        subject.load_json(json)
        expect(subject.length).to eq(1)
        expect(subject.emojis.length).to eq(1)
        expect(subject.emojis.first.name).to eq("test")
        expect(subject.emojis.first.picture_link).to eq("test_link")
      end

      it "can clear the list" do
        subject.load_json(json)
        expect(subject.length).to eq(1)
        subject.clear
        expect(subject.length).to eq(0)
      end

      it "can convert to valid json" do
        subject.load_json(json)
        output = subject.to_json
        list = JSON.load(output)
        expect(list).to have_key("emoji")
        expect(list["emoji"]).to be_a_kind_of Array
        expect(list["emoji"].first).to have_key("name")
        expect(list["emoji"].first).to have_key("picture_link")
        expect(list["emoji"].first["name"]).to eq("test")
        expect(list["emoji"].first["picture_link"]).to eq("test_link")
      end
    end
  end
end

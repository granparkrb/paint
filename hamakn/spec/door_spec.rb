$:.unshift("./lib")
require "door"

describe Door do
  describe ".panel" do
    context "Use data/door3.txt" do
      before do
        @door = Door.new("./data/door3.txt")
      end

      it { expect(@door.panel(0, 0)).to eq("0") }
      it { expect(@door.panel(6, 3)).to eq("0") }
      it { expect(@door.panel(3, 6)).to eq("1") }
      it { expect(@door.panel(6, 6)).to eq("0") }
      it { expect { @door.panel(7, 7) }.to raise_error }
      it { expect { @door.panel(-1, -1) }.to raise_error }
    end
  end

  describe "#brush_size" do
    shared_examples "brush_size_for" do |filepath, size|
      context "Use #{filepath}" do
        it { expect(Door.new(filepath).brush_size).to eq(size) }
      end
    end

    it_should_behave_like "brush_size_for", "./data/door1.txt", 2
    it_should_behave_like "brush_size_for", "./data/door2.txt", 3
    it_should_behave_like "brush_size_for", "./data/door3.txt", 1
    it_should_behave_like "brush_size_for", "./data/door4.txt", 1
    it_should_behave_like "brush_size_for", "./data/door5.txt", 1
  end
end

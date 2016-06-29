require "../spec_helper"

module Optarg::DefaultValueFeature
  class Model < ::Optarg::Model
    string "-s", default: "string"
    bool "-b", default: false
    array "-a", default: %w(1 2 3)
  end

  it "Default Value" do
    result = Model.parse(%w())
    result.s.should eq "string"
    result.b?.should be_false
    result.a.should eq %w(1 2 3)
  end
end

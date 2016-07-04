require "../spec_helper"

module Optarg::AccessibleArgumentsFeature
  class Model < ::Optarg::Model
    arg "src_dir"
    arg "build_dir"
  end

  it "Accessible Arguments" do
    result = Model.parse(%w(/path/to/src /path/to/build and more))
    result.src_dir.should eq "/path/to/src"
    result.build_dir.should eq "/path/to/build"
    result.args.should eq ["/path/to/src", "/path/to/build", "and", "more"]
    result.args.src_dir.should eq "/path/to/src"
    result.args.build_dir.should eq "/path/to/build"
    result.args.named.should eq({"src_dir" => "/path/to/src", "build_dir" => "/path/to/build"})
    result.args.nameless.should eq ["and", "more"]
  end
end
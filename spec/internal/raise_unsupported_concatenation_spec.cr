require "../spec_helper"

module OptargRaiseUnknownOptionIfConcatenatedOptionsNotMatchedFeature
  class Model < Optarg::Model
    string "-s"
  end

  it name do
    expect_raises(Optarg::UnsupportedConcatenation, Optarg::UnsupportedConcatenation.new("-s").message) { Model.parse %w(-sa)}
  end
end

require 'test_helper'

class GuideTest < ActiveSupport::TestCase

  def setup
    @guide = Guide.new(title: "How to test my application models?", instructions: "Run unit tests!")
  end

  test "guide should be valid" do
    assert @guide.valid?
  end

  test "title should be present" do
    @guide.title = " "
    assert_not @guide.valid?
  end

  test "instructions should be present" do
    @guide.instructions = " "
    assert_not @guide.valid?
  end

  test "instructions should not be less than 5 characters" do
    @guide.instructions = "a" * 3
    assert_not @guide.valid?
  end

  test "instructions should not be more than 500 characters" do
    @guide.instructions = "a" * 501
    assert_not @guide.valid?
  end

end

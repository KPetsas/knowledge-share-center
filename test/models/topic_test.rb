require 'test_helper'

class TopicTest < ActiveSupport::TestCase

  def setup
    @topic = Topic.create!(name: "Ruby on Rails")
  end

  test "topic should be valid" do
    assert @topic.valid?
  end

  test "topic name should be present" do
    @topic.name = " "
    assert_not @topic.valid?
  end

  test "topic name should not be less than 3 characters" do
    @topic.name = "a" * 2
    assert_not @topic.valid?
  end

  test "topic name should not be more than 25 characters" do
    @topic.name = "a" * 26
    assert_not @topic.valid?
  end

  test "topic should be unique" do
    duplicate_topic = @topic.dup
    duplicate_topic.name = @topic.name
    assert_not duplicate_topic.valid?
  end

end

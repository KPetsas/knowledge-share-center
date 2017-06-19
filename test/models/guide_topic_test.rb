require 'test_helper'

class GuideTopicTest < ActiveSupport::TestCase

  def setup
    @expert = Expert.create!(expertname: "User", email: "user@example.com",
                        password: "password", password_confirmation: "password")
    @guide = @expert.guides.create!(title: "How to test my application models?", instructions: "Run unit tests!")
    @topic = @guide.topics.create!(name: "Ruby on Rails")

    @guide_topic = GuideTopic.first
  end

  test "without guide id should be invalid" do
    @guide_topic.guide_id = nil
    assert_not @guide_topic.valid?
  end

  test "without topic id should be invalid" do
    @guide_topic.topic_id = nil
    assert_not @guide_topic.valid?
  end

end

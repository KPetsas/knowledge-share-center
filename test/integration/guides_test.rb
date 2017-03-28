require 'test_helper'

class GuidesTest < ActionDispatch::IntegrationTest

  def setup
    @user = Expert.create!(expertname: "TestUser", email: "test@example.com")
    # One way
    @guide = Guide.create(title: "How to test a new feature of my application?", instructions: "Write integration tests.", expert: @user)
    # Another way
    @guide2 = @user.guides.build(title: "How to run my rails tests?", instructions: "Just type rails test")
    @guide2.save
  end

  test "should get guides index" do
    get guides_path
    assert_response :success
  end

  test "should get guides list" do
    get guides_path
    assert_template 'guides/index'
    assert_match @guide.title, response.body
    assert_match @guide2.title, response.body
  end

end

require 'test_helper'

class ExpertsShowTest < ActionDispatch::IntegrationTest

  def setup
    @user = Expert.create!(expertname: "TestUser", email: "test@example.com",
                        password: "password", password_confirmation: "password")
    @guide = Guide.create(title: "How to test a new feature of my application?", instructions: "Write integration tests.", expert: @user)
    @guide2 = Guide.create(title: "How to run my rails tests?", instructions: "Just type rails test", expert: @user)
  end

  test "should get experts show" do
    get expert_path(@user)
    assert_template 'experts/show'
    assert_select "a[href=?]", guide_path(@guide), text: @guide.title
    assert_select "a[href=?]", guide_path(@guide2), text: @guide2.title
    assert_match @guide.instructions, response.body
    assert_match @guide2.instructions, response.body
    assert_match @user.expertname, response.body
  end

end

require 'test_helper'

class ExpertsSignUpTest < ActionDispatch::IntegrationTest

  test "shuold get sign up path" do
    get signup_path
    assert_response :success
  end

  test "reject an invalid sign up" do
    get signup_path
    assert_no_difference "Expert.count" do
      post experts_path, params: { expert: { expertname: " ", email: " ", password: "password",
                                             password_confirmation: " " } }
    end
    assert_template 'experts/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "accept a valid sign up" do
    get signup_path
    assert_difference "Expert.count", 1 do
      post experts_path, params: { expert: { expertname: "Test", email: "Test@example.com", password: "password",
                                             password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'experts/show'
    assert_not flash.empty?
  end

end

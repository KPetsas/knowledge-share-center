require 'test_helper'

class ExpertsLoginTest < ActionDispatch::IntegrationTest

  def setup
    @expert = Expert.create!(expertname: "test", email: "test@example.com", password: "password")
  end

  test "invalid login should be rejected" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: " ", password: " " } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0  # it should not be present when log in fails
    # flash should be empty if we redirect to another route
    get root_path
    assert flash.empty?
  end

  test "valid login credentials accepted and begin session" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @expert.email, password: @expert.password } }
    assert_redirected_to @expert
    follow_redirect!
    assert_template 'experts/show'
    assert_not flash.empty?
    assert_select "a[href=?]", login_path, count: 0  # it should not be present when logged in
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", expert_path(@expert)
    assert_select "a[href=?]", edit_expert_path(@expert)
  end

end

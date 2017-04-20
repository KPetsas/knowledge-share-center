require 'test_helper'

class ExpertsEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = Expert.create!(expertname: "TestUser", email: "test@example.com",
                        password: "password", password_confirmation: "password")
    @expert = Expert.create!(expertname: "Test", email: "secondTest@example.com", password: "password",
                                           password_confirmation: "password")
    @admin = Expert.create!(expertname: "Admin", email: "admin@example.com", password: "password",
                                          password_confirmation: "password", admin: true)
  end

  test "reject an invalid edit" do
    sign_in_as(@user, "password")
    get edit_expert_path(@user)
    assert_template 'experts/edit'
    # The has_secure_password does not enforce to have password and password_confirmation in the edit request
    patch expert_path(@user), params: { expert: { expertname: " ", email: "test@example.com" } }
    assert_template 'experts/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "accept a valid edit" do
    sign_in_as(@user, "password")
    get edit_expert_path(@user)
    assert_template 'experts/edit'
    expert_new_name = "User-001"
    expert_new_email = "test@example.com"
    # The has_secure_password does not enforce to have password and password_confirmation in the edit request
    patch expert_path(@user), params: { expert: { expertname: expert_new_name, email: expert_new_email } }
    # make sure to redirect to the show page
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload
    assert_match expert_new_name, @user.expertname
    assert_match expert_new_email, @user.email
  end

  test "accept edit by admin" do
    sign_in_as(@admin, "password")
    get edit_expert_path(@user)
    assert_template 'experts/edit'
    expert_new_name = "User-010"
    expert_new_email = "test2@example.com"
    # The has_secure_password does not enforce to have password and password_confirmation in the edit request
    patch expert_path(@user), params: { expert: { expertname: expert_new_name, email: expert_new_email } }
    # make sure to redirect to the show page
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload
    assert_match expert_new_name, @user.expertname
    assert_match expert_new_email, @user.email
  end

  test "reject edit attempt by another non-admin user" do
    sign_in_as(@expert, "password")
    expert_new_name = "Test"
    expert_new_email = "secondTest@example.com"
    # The has_secure_password does not enforce to have password and password_confirmation in the edit request
    patch expert_path(@user), params: { expert: { expertname: expert_new_name, email: expert_new_email } }
    # make sure to redirect to the show page
    assert_redirected_to experts_path
    assert_not flash.empty?
    @user.reload
    assert_match "TestUser", @user.expertname
    assert_match "test@example.com", @user.email
  end

end

require 'test_helper'

class ExpertsIndexTest < ActionDispatch::IntegrationTest

  def setup
    @expert = Expert.create!(expertname: "TestUser", email: "test@example.com",
                        password: "password", password_confirmation: "password")
    @expert2 = Expert.create!(expertname: "Test", email: "secondTest@example.com", password: "password",
                                           password_confirmation: "password")
    @admin = Expert.create!(expertname: "Admin", email: "admin@example.com", password: "password",
                                          password_confirmation: "password", admin: true)
  end

  test "should get experts list" do
    get experts_path
    assert_template 'experts/index'
    assert_select "a[href=?]", expert_path(@expert), text: @expert.expertname
    assert_select "a[href=?]", expert_path(@expert2), text: @expert2.expertname
  end

  test "should delete expert" do
    sign_in_as(@admin, "password")
    get experts_path
    assert_template 'experts/index'
    assert_difference 'Expert.count', -1 do
      delete expert_path(@expert)
    end
    assert_redirected_to experts_path
    assert_not flash.empty?
  end

end

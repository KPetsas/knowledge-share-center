require 'test_helper'

class ExpertsIndexTest < ActionDispatch::IntegrationTest

  def setup
    @expert = Expert.create!(expertname: "TestUser", email: "test@example.com",
                        password: "password", password_confirmation: "password")
    @expert2 = Expert.create!(expertname: "Test", email: "secondTest@example.com", password: "password",
                                           password_confirmation: "password")
  end

  test "should get experts list" do
    get experts_path
    assert_template 'experts/index'
    assert_select "a[href=?]", expert_path(@expert), text: @expert.expertname
    assert_select "a[href=?]", expert_path(@expert2), text: @expert2.expertname
  end

end

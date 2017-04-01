require 'test_helper'

class GuidesDeleteTest < ActionDispatch::IntegrationTest

  def setup
    @user = Expert.create!(expertname: "TestUser", email: "test@example.com")
    @guide = Guide.create(title: "How to test a new feature of my application?", instructions: "Write integration tests.", expert: @user)
  end

  test "successfully delete a guide" do
    # go to the show route
    get guide_path(@guide)
    assert_template 'guides/show'
    # find the delete button
    assert_select "a[href=?]", guide_path(@guide), text: "Delete this guide"
    # deleting the guide will decrease the guides count in DB
    assert_difference 'Guide.count', -1 do
      delete guide_path(@guide)
    end
    assert_redirected_to guides_path
    assert_not flash.empty?
  end

end

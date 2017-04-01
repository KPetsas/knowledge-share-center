require 'test_helper'

class GuidesEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = Expert.create!(expertname: "TestUser", email: "test@example.com")
    @guide = Guide.create(title: "How to test a new feature of my application?", instructions: "Write integration tests.", expert: @user)
  end

  test "reject invalid guide update" do
    get edit_guide_path(@guide)
    assert_template 'guides/edit'
    patch guide_path(@guide), params: { guide: { title: " ", instructions: "some instructions..." } }
    assert_template 'guides/edit'
    # ensure that the errors are displayed
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "successful guide edit action" do
    get edit_guide_path(@guide)
    assert_template 'guides/edit'
    updated_title = "my updated guide"
    updated_instructions = "some instructions..."
    patch guide_path(@guide), params: { guide: { title: updated_title, instructions: updated_instructions } }
    assert_redirected_to @guide
    # follow_redirect!
    assert_not flash.empty?
    # Fetch from DB the latest updates for the specified guide
    @guide.reload
    assert_match updated_title, @guide.title
    assert_match updated_instructions, @guide.instructions
  end

end

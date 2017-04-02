require 'test_helper'

class GuidesTest < ActionDispatch::IntegrationTest

  def setup
    @user = Expert.create!(expertname: "TestUser", email: "test@example.com",
                        password: "password", password_confirmation: "password")
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
    # assert_match @guide.title, response.body
    assert_select "a[href=?]", guide_path(@guide), text: @guide.title
    assert_select "a[href=?]", guide_path(@guide2), text: @guide2.title
  end

  test "should get guides show" do
    get guide_path(@guide)
    assert_template 'guides/show'
    assert_match @guide.title, response.body
    assert_match @guide.instructions, response.body
    assert_match @user.expertname, response.body
    assert_select "a[href=?]", edit_guide_path(@guide), text: "Edit this guide"
    assert_select "a[href=?]", guide_path(@guide), text: "Delete this guide"
    assert_select "a[href=?]", guides_path, text: "Go back to guides list"
  end

  test "create new valid guide" do
    get new_guide_path
    assert_template 'guides/new'
    title_of_guide = "How to cook chicken saute"
    guide_instructions = "Add chicken, add vegetables, cook for 20 minutes."
    assert_difference 'Guide.count', 1 do
      post guides_path, params: { guide: { title: title_of_guide, instructions: guide_instructions}}
    end
    follow_redirect!  # redirect should go to show page
    assert_match title_of_guide.capitalize, response.body  # capitalize because this format is followed in page_title partial
    assert_match guide_instructions, response.body
  end

  test "reject invalid guide submissions" do
    get new_guide_path
    assert_template 'guides/new'
    assert_no_difference 'Guide.count' do
      post guides_path, params: { guide: { title: " ", instructions: " " } }
    end
    # POSTing empty title and instructions should show again the new form with error messages
    assert_template 'guides/new'
    # ensure that the errors are displayed
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end

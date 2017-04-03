require 'test_helper'

class ExpertTest < ActiveSupport::TestCase

  def setup
    @expert = Expert.new(expertname: "KPetsas", email: "kpetsas@example.com",
                        password: "password", password_confirmation: "password")
  end

  test "expert model should be valid" do
    assert @expert.valid?
  end

  test "expert name should be present" do
    @expert.expertname = " "
    assert_not @expert.valid?
  end

  test "expert name should be less than 30 characters" do
    @expert.expertname = "a" * 31
    assert_not @expert.valid?
  end

  test "email should be present" do
    @expert.email = " "
    assert_not @expert.valid?
  end

  test "email should not be too long" do
    @expert.email = "a" * 245 + "@example.com"
    assert_not @expert.valid?
  end

  test "email address should accept correct format" do
    valid_emails = %w(user@example.com TEST@gmail.com M.first@yahoo.gr another+name@example.org)
    valid_emails.each do |valids|
      @expert.email = valids
      assert @expert.valid?, "#{valids.inspect} should be valid"
    end
  end

  test "should reject invalid email addresses" do
    invalid_emails = %w(test@example test@example,com test.name@gmail. test@example+foo.com)
    invalid_emails.each do |invalids|
      @expert.email = invalids
      assert_not @expert.valid?, "#{invalids.inspect} should be invalid"
    end
  end

  test "email should be unique and case insensitive" do
    duplicate_expert = @expert.dup
    duplicate_expert.email = @expert.email.upcase
    @expert.save
    assert_not duplicate_expert.valid?
  end

  test "email should be lowercase before hitting db" do
    email = "TeSt@exAmpLe.com"
    @expert.email = email
    @expert.save
    assert_equal email.downcase, @expert.reload.email
  end

  test "password should be present" do
    @expert.password = @expert.password_confirmation = " "
    assert_not @expert.valid?
  end

  test "password should be at least 5 characters" do
    @expert.password = @expert.password_confirmation = "p" * 4
    assert_not @expert.valid?
  end

  test "associated guides should be destroyed" do
    @expert.save
    @expert.guides.create!(title: "Testing destroy", instructions: "Testing destroy funcion")
    assert_difference 'Guide.count', -1 do
      @expert.destroy
    end
  end

end

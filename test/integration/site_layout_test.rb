require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "layout_links" do
    get root_path
    assert_template 'static_pages/home'

    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", login_path

    get contact_path
    assert_select "title", full_title("Contact")

    get signup_path
    assert_select "title", full_title("Sign up")

    get help_path
    assert_select "title", full_title("Help")

    get about_path
    assert_select "title", full_title("About")

    get login_path
    assert_select "title", full_title("Log in")

    log_in_as(@user)
    follow_redirect!
    assert_select "a[href=?]", users_path
    get users_path
    assert_select "title", full_title("All users")
  end
end

require 'test_helper'

    def setup
     @user = users(:michael)
    end

class SiteLayoutTest < ActionDispatch::IntegrationTest
   test "layout links for non-logged in users" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contect_path
    get signup_path
    assert_select "title", full_title("Sign up")
  end

  test "layout links for logged in users" do
    # get login_path
    # post login_path, session: { email: @user.email, password: 'password' }
    # log_in_as(@user)
    # assert_redirected_to @user
    # follow_redirect!
    # assert_template 'users/show'
    # assert_select "a[href=?]", root_path, count: 2
    # assert_select "a[href=?]", help_path
    # assert_select "a[href=?]", users_path
    # assert_select "a[href=?]", user_path(@user)
    # assert_select "a[href=?]", edit_user_path(@user)
    # assert_select "a[href=?]", logout_path



  end


end

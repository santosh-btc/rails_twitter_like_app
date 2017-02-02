require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
	include ApplicationHelper

	def setup
		@user = users(:michael)
    log_in_as(@user)
	end


   test "profile dispaly" do

     get user_path(@user)
     assert_template 'users/show'
     assert_select 'title', full_title(@user.name)
     assert_select 'h1', text: @user.name
     assert_select 'h1>img.gravatar'
     assert_match @user.microposts.count.to_s, response.body
     assert_select 'div.pagination'
      	@user.microposts.paginate(page: 1).each do |micropost|
     		assert_match micropost.content, response.body
 		end
    assert_select 'div.stats'
     assert_select "a[href=?]", following_user_path(@user)
     assert_match @user.following.count.to_s, response.body
     assert_select "a[href=?]", followers_user_path(@user)
     assert_match @user.followers.count.to_s, response.body

     # get root_path
     # assert_template 'static_pages/home'
     # assert_select 'div.stats'
     # assert_select "a[href=?]", following_user_path(@user)
     # assert_match @user.following.count.to_s, response.body
     # assert_select "a[href=?]", followers_user_path(@user)
     # assert_match @user.followers.count.to_s, response.body

     
   end

   test "stats dispaly on home when user login" do
     
     get root_path
     assert_template 'static_pages/home'
     assert_select 'div.stats'
     assert_select "a[href=?]", following_user_path(@user)
     assert_match @user.following.count.to_s, response.body
     assert_select "a[href=?]", followers_user_path(@user)
     assert_match @user.followers.count.to_s, response.body
    end
end

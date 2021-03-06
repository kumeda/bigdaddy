# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  name                         :string           not null
#  description                  :string           not null
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  icon_image                   :string
#  email                        :string           not null
#  crypted_password             :string
#  salt                         :string
#  remember_me_token            :string
#  remember_me_token_expires_at :datetime
#  city_id                      :integer
#

require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { description: @user.description, icon_url: @user.icon_url, login_id: @user.login_id, name: @user.name, password: @user.password }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { description: @user.description, icon_url: @user.icon_url, login_id: @user.login_id, name: @user.name, password: @user.password }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end

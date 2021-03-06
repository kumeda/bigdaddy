# == Schema Information
#
# Table name: spots
#
#  id               :integer          not null, primary key
#  name             :string           not null
#  yelp_url         :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  latitude         :float
#  longitude        :float
#  display_address  :string
#  yelp_business_id :string
#  city_id          :integer
#  yelp_image_url   :string
#

require 'test_helper'

class SpotsControllerTest < ActionController::TestCase
  setup do
    @spot = spots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:spots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create spot" do
    assert_difference('Spot.count') do
      post :create, spot: { name: @spot.name, yelp_url: @spot.yelp_url }
    end

    assert_redirected_to spot_path(assigns(:spot))
  end

  test "should show spot" do
    get :show, id: @spot
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @spot
    assert_response :success
  end

  test "should update spot" do
    patch :update, id: @spot, spot: { name: @spot.name, yelp_url: @spot.yelp_url }
    assert_redirected_to spot_path(assigns(:spot))
  end

  test "should destroy spot" do
    assert_difference('Spot.count', -1) do
      delete :destroy, id: @spot
    end

    assert_redirected_to spots_path
  end
end

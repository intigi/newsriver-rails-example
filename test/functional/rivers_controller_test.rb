require 'test_helper'

class RiversControllerTest < ActionController::TestCase
  setup do
    @river = rivers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rivers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create river" do
    assert_difference('River.count') do
      post :create, river: { body: @river.body, intigi_recommendations_url: @river.intigi_recommendations_url, title: @river.title }
    end

    assert_redirected_to river_path(assigns(:river))
  end

  test "should show river" do
    get :show, id: @river
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @river
    assert_response :success
  end

  test "should update river" do
    put :update, id: @river, river: { body: @river.body, intigi_recommendations_url: @river.intigi_recommendations_url, title: @river.title }
    assert_redirected_to river_path(assigns(:river))
  end

  test "should destroy river" do
    assert_difference('River.count', -1) do
      delete :destroy, id: @river
    end

    assert_redirected_to rivers_path
  end
end

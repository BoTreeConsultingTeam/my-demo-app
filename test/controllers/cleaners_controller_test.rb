require 'test_helper'

class CleanersControllerTest < ActionController::TestCase
  setup do
    @cleaner = cleaners(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cleaners)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cleaner" do
    assert_difference('Cleaner.count') do
      post :create, cleaner: { first_name: @cleaner.first_name, last_name: @cleaner.last_name, quality_score: @cleaner.quality_score }
    end

    assert_redirected_to cleaner_path(assigns(:cleaner))
  end

  test "should show cleaner" do
    get :show, id: @cleaner
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cleaner
    assert_response :success
  end

  test "should update cleaner" do
    patch :update, id: @cleaner, cleaner: { first_name: @cleaner.first_name, last_name: @cleaner.last_name, quality_score: @cleaner.quality_score }
    assert_redirected_to cleaner_path(assigns(:cleaner))
  end

  test "should destroy cleaner" do
    assert_difference('Cleaner.count', -1) do
      delete :destroy, id: @cleaner
    end

    assert_redirected_to cleaners_path
  end
end

require 'test_helper'

module Saphira
  class FileItemsControllerTest < ActionController::TestCase
    setup do
      @file_item = file_items(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:file_items)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create file_item" do
      assert_difference('FileItem.count') do
        post :create, file_item: @file_item.attributes
      end
  
      assert_redirected_to file_item_path(assigns(:file_item))
    end
  
    test "should show file_item" do
      get :show, id: @file_item.to_param
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @file_item.to_param
      assert_response :success
    end
  
    test "should update file_item" do
      put :update, id: @file_item.to_param, file_item: @file_item.attributes
      assert_redirected_to file_item_path(assigns(:file_item))
    end
  
    test "should destroy file_item" do
      assert_difference('FileItem.count', -1) do
        delete :destroy, id: @file_item.to_param
      end
  
      assert_redirected_to file_items_path
    end
  end
end

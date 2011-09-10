require 'test_helper'

module Saphira
  class ImageVariantsControllerTest < ActionController::TestCase
    setup do
      @image_variant = image_variants(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:image_variants)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create image_variant" do
      assert_difference('ImageVariant.count') do
        post :create, image_variant: @image_variant.attributes
      end
  
      assert_redirected_to image_variant_path(assigns(:image_variant))
    end
  
    test "should show image_variant" do
      get :show, id: @image_variant.to_param
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @image_variant.to_param
      assert_response :success
    end
  
    test "should update image_variant" do
      put :update, id: @image_variant.to_param, image_variant: @image_variant.attributes
      assert_redirected_to image_variant_path(assigns(:image_variant))
    end
  
    test "should destroy image_variant" do
      assert_difference('ImageVariant.count', -1) do
        delete :destroy, id: @image_variant.to_param
      end
  
      assert_redirected_to image_variants_path
    end
  end
end

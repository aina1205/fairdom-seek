require 'test_helper'

class ModelsControllerTest < ActionController::TestCase

  fixtures :all

  include AuthenticatedTestHelper
  
  def setup
    login_as(:model_owner)
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:models)
  end

  test "should get new" do
    get :new    
    assert_response :success
  end

  test "should create model" do
    assert_difference('Model.count') do
      post :create, :model => valid_model, :sharing=>valid_sharing
    end

    assert_redirected_to model_path(assigns(:model))
  end

  test "should create with preferred environment" do
    assert_difference('Model.count') do
      model=valid_model
      model[:recommended_environment_id]=recommended_model_environments(:jws).id
      post :create, :model => model, :sharing=>valid_sharing
    end

    m=assigns(:model)
    assert m
    assert_equal "JWS Online",m.recommended_environment.title
  end

  test "should show model" do
    get :show, :id => models(:teusink).id
    assert_response :success
  end

  test "should show model with format and type" do
    get :show, :id => models(:model_with_format_and_type).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => models(:teusink).id
    assert_response :success
  end

  test "should update model" do
    put :update, :id => models(:teusink).id, :model => { }
    assert_redirected_to model_path(assigns(:model))
  end

  test "should update model with model type and format" do
    type=model_types(:ODE)
    format=model_formats(:SBML)
    put :update, :id => models(:teusink).id, :model => {:model_type_id=>type.id,:model_format_id=>format.id }
    assert assigns(:model)
    assert_equal type,assigns(:model).model_type
    assert_equal format,assigns(:model).model_format
  end

  test "should destroy model" do
    assert_difference('Model.count', -1) do
      delete :destroy, :id => models(:teusink).id
    end

    assert_redirected_to models_path
  end

  test "should add model type" do
    login_as(:quentin)
    assert_difference('ModelType.count',1) do
      post :create_model_metadata, :attribute=>"model_type",:model_type=>"fred"
    end

    assert_response :success
    assert_not_nil ModelType.find(:first,:conditions=>{:title=>"fred"})

  end

  test "should add model type as pal" do
    login_as(:pal_user)
    assert_difference('ModelType.count',1) do
      post :create_model_metadata, :attribute=>"model_type",:model_type=>"fred"
    end

    assert_response :success
    assert_not_nil ModelType.find(:first,:conditions=>{:title=>"fred"})

  end

  test "should not add model type as non pal" do
    login_as(:aaron)
    assert_no_difference('ModelType.count') do
      post :create_model_metadata, :attribute=>"model_type",:model_type=>"fred"
    end

    assert_nil ModelType.find(:first,:conditions=>{:title=>"fred"})

  end

  test "should not add duplicate model type" do
    login_as(:quentin)
    m=model_types(:ODE)
    assert_no_difference('ModelType.count') do
      post :create_model_metadata, :attribute=>"model_type",:model_type=>m.title
    end

  end

  test "should add model format" do
    login_as(:quentin)
    assert_difference('ModelFormat.count',1) do
      post :create_model_metadata, :attribute=>"model_format",:model_format=>"fred"
    end

    assert_response :success
    assert_not_nil ModelFormat.find(:first,:conditions=>{:title=>"fred"})

  end

  test "should add model format as pal" do
    login_as(:pal_user)
    assert_difference('ModelFormat.count',1) do
      post :create_model_metadata, :attribute=>"model_format",:model_format=>"fred"
    end

    assert_response :success
    assert_not_nil ModelFormat.find(:first,:conditions=>{:title=>"fred"})

  end

  test "should not add model format as non pal" do
    login_as(:aaron)
    assert_no_difference('ModelFormat.count') do
      post :create_model_metadata, :attribute=>"model_format",:model_format=>"fred"
    end

    assert_nil ModelFormat.find(:first,:conditions=>{:title=>"fred"})

  end

  test "should not add duplicate model format" do
    login_as(:quentin)
    m=model_formats(:SBML)
    assert_no_difference('ModelFormat.count') do
      post :create_model_metadata, :attribute=>"model_format",:model_format=>m.title
    end

  end

  test "should update model format" do
    login_as(:quentin)
    m=model_formats(:SBML)

    assert_nil ModelFormat.find(:first,:conditions=>{:title=>"fred"})

    assert_no_difference('ModelFormat.count') do
      put :update_model_metadata, :attribute=>"model_format",:updated_model_format=>"fred",:updated_model_format_id=>m.id
    end

    assert_not_nil ModelFormat.find(:first,:conditions=>{:title=>"fred"})
  end

  test "should update model format as pal" do
    login_as(:pal_user)
    m=model_formats(:SBML)

    assert_nil ModelFormat.find(:first,:conditions=>{:title=>"fred"})

    assert_no_difference('ModelFormat.count') do
      put :update_model_metadata, :attribute=>"model_format",:updated_model_format=>"fred",:updated_model_format_id=>m.id
    end

    assert_not_nil ModelFormat.find(:first,:conditions=>{:title=>"fred"})
  end

  test "should not update model format as non pal" do
    login_as(:aaron)
    m=model_formats(:SBML)

    assert_nil ModelFormat.find(:first,:conditions=>{:title=>"fred"})

    assert_no_difference('ModelFormat.count') do
      put :update_model_metadata, :attribute=>"model_format",:updated_model_format=>"fred",:updated_model_format_id=>m.id
    end

    assert_nil ModelFormat.find(:first,:conditions=>{:title=>"fred"})
  end

  test "should update model type" do
    login_as(:quentin)
    m=model_types(:ODE)

    assert_nil ModelType.find(:first,:conditions=>{:title=>"fred"})

    assert_no_difference('ModelFormat.count') do
      put :update_model_metadata, :attribute=>"model_type",:updated_model_type=>"fred",:updated_model_type_id=>m.id
    end

    assert_not_nil ModelType.find(:first,:conditions=>{:title=>"fred"})
  end

  test "should update model type as pal" do
    login_as(:pal_user)
    m=model_types(:ODE)

    assert_nil ModelType.find(:first,:conditions=>{:title=>"fred"})

    assert_no_difference('ModelFormat.count') do
      put :update_model_metadata, :attribute=>"model_type",:updated_model_type=>"fred",:updated_model_type_id=>m.id
    end

    assert_not_nil ModelType.find(:first,:conditions=>{:title=>"fred"})
  end

  test "should not update model type as non pal" do
    login_as(:aaron)
    m=model_types(:ODE)

    assert_nil ModelType.find(:first,:conditions=>{:title=>"fred"})

    assert_no_difference('ModelFormat.count') do
      put :update_model_metadata, :attribute=>"model_type",:updated_model_type=>"fred",:updated_model_type_id=>m.id
    end

    assert_nil ModelType.find(:first,:conditions=>{:title=>"fred"})
  end

  def valid_model
    { :title=>"Test",:data=>fixture_file_upload('files/little_file.txt')}
  end

  def valid_sharing
    {
      :use_whitelist=>"0",
      :user_blacklist=>"0",
      :sharing_scope=>Policy::ALL_REGISTERED_USERS,
      :permissions=>{:contributor_types=>ActiveSupport::JSON.encode("Person"),:values=>ActiveSupport::JSON.encode({})}
    }
  end
  
end

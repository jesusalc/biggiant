require 'test_helper'

class ParsersControllerTest < ActionController::TestCase
  setup do
    @parser = parsers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parsers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parser" do
    assert_difference('Parser.count') do
      post :create, parser: { item_description: @parser.item_description, item_price: @parser.item_price, merchant_address: @parser.merchant_address, merchant_name: @parser.merchant_name, purchase_count: @parser.purchase_count, purchaser_name: @parser.purchaser_name }
    end

    assert_redirected_to parser_path(assigns(:parser))
  end

  test "should show parser" do
    get :show, id: @parser
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @parser
    assert_response :success
  end

  test "should update parser" do
    put :update, id: @parser, parser: { item_description: @parser.item_description, item_price: @parser.item_price, merchant_address: @parser.merchant_address, merchant_name: @parser.merchant_name, purchase_count: @parser.purchase_count, purchaser_name: @parser.purchaser_name }
    assert_redirected_to parser_path(assigns(:parser))
  end

  test "should destroy parser" do
    assert_difference('Parser.count', -1) do
      delete :destroy, id: @parser
    end

    assert_redirected_to parsers_path
  end
  
  test "uploading file traveling creates Parser" do
    @file_traveling = fixture_file_upload('example_input.tab')
    @file_traveling.class_eval { attr_reader :tempfile }
    assert_difference("Parser.count", 2) do
      post :file_parser, :parsers => { :file_traveling => @file_traveling }
    end
  end

  test "not providing file traveling redirects back to #index with error message" do
    post :file_parser
    assert_redirected_to :action => :index
    assert !flash[:error].blank?
  end
end

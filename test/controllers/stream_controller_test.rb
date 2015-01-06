require 'test_helper'

class StreamControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get stream" do
    get :stream
    assert_response :success
  end

end

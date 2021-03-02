require 'test_helper'

class OhControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end

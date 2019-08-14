require 'test_helper'

class InfosControllerTest < ActionDispatch::IntegrationTest
  test "should get view" do
    get root_path
    assert_response :success
    get index_path
    assert_response :success
  end

end

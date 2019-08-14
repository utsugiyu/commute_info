require 'test_helper'

class InfosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get infos_new_url
    assert_response :success
  end

end

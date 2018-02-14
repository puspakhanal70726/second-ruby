require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get puspa" do
    get home_puspa_url
    assert_response :success
  end

  test "should get khanal" do
    get home_khanal_url
    assert_response :success
  end

end

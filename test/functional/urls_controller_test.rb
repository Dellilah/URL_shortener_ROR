require 'test_helper'

class UrlsControllerTest < ActionController::TestCase
  test "should get shorten_url" do
    get :shorten_url
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get check_stats" do
    get :check_stats
    assert_response :success
  end

end

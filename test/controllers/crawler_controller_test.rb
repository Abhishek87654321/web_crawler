require "test_helper"

class CrawlerControllerTest < ActionDispatch::IntegrationTest
  test "should get crawl" do
    get crawler_crawl_url
    assert_response :success
  end
end

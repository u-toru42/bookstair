require "test_helper"

class BookshelfboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bookshelfboards_index_url
    assert_response :success
  end

  test "should get show" do
    get bookshelfboards_show_url
    assert_response :success
  end

  test "should get new" do
    get bookshelfboards_new_url
    assert_response :success
  end

  test "should get edit" do
    get bookshelfboards_edit_url
    assert_response :success
  end
end

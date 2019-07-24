require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'should get home with image with tags' do
    get root_url

    assert_response :success
    assert_select 'h1', text: 'Image Sharer'
    assert_select '.card img[src]'
    assert_select '.card .badge[href=?]', root_url + '?tag=fun', text: 'fun'
  end

  test 'should show empty if no images' do
    Image.delete_all

    get root_url
    assert_response :success
    assert_select 'h3', text: 'No Images found for this tag'
    assert_select 'p a[href=?]', root_url
  end
end

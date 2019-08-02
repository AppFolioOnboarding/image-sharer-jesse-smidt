require 'test_helper'
require 'flow_test_helper'
require 'page_objects/images_index_page'

class ImagesFlowTest < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome
  test 'delete image' do
    images_index_page = PageObjects::ImagesIndexPage.visit
    src = images_index_page.images.first.image_src
    new_images_index_page = images_index_page.images.first.delete!

    refute_equal src, new_images_index_page.images.first&.image_src
    assert_equal PageObjects::ImagesIndexPage, new_images_index_page.class
  end
end

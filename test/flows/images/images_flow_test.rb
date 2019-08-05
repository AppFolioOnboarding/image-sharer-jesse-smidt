require 'test_helper'
require 'flow_test_helper'
require 'page_objects/images_index_page'
require 'page_objects/image_edit_page'
require 'page_objects/image_new_page'

class ImagesFlowTest < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome
  test 'create image' do
    image_new_page = PageObjects::ImageNewPage.visit
    assert_difference('Image.count', 1) do
      image_new_page.create_image('https://appfolio.com', 'one, two')
    end
  end

  test 'create image invalid url' do
    image_new_page = PageObjects::ImageNewPage.visit
    assert_difference('Image.count', 0) do
      image_new_page.create_image_invalid('bad')
    end
  end

  test 'update image' do
    image = Image.first
    new_tags = image.tag_list + ['new']
    image_edit_page = PageObjects::ImageEditPage.visit(image)
    images_index_page = image_edit_page.update_tags!(new_tags)
    assert_equal new_tags, Image.find(image.id).tag_list
    assert_equal PageObjects::ImagesIndexPage, images_index_page.class
  end

  test 'filter images' do
    images_index_page = PageObjects::ImagesIndexPage.visit
    first_badge_text = images_index_page.images.first.badges.first.text
    second_images_index_page = PageObjects::ImagesIndexPage.visit(tag: first_badge_text)
    assert_equal second_images_index_page.images.first.badges.first.text, first_badge_text
    third_images_index_page = PageObjects::ImagesIndexPage.visit(tag: 'a tag that does not exist')
    assert_equal 0, third_images_index_page.images.size
  end

  test 'delete image' do
    images_index_page = PageObjects::ImagesIndexPage.visit
    src = images_index_page.images.first.image_src
    new_images_index_page = images_index_page.images.first.delete!

    refute_equal src, new_images_index_page.images.first&.image_src
    assert_equal PageObjects::ImagesIndexPage, new_images_index_page.class
  end
end

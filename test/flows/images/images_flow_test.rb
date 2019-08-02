require 'test_helper'
require 'flow_test_helper'
require 'page_objects/images_index_page'

class ImagesFlowTest < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome
  test 'create image' do
    visit new_image_url
    fill_in 'Url', with: 'https://appfolio.com'
    fill_in 'Image Tags', with: 'one, two'
    assert_difference('Image.count', 1) do
      click_on 'Create'
    end
  end

  test 'create image invalid url' do
    visit new_image_url
    fill_in 'Url', with: 'bad'
    assert_difference('Image.count', 0) do
      click_on 'Create'
    end
  end

  test 'update image' do
    image = Image.first
    new_tags = image.tag_list + ['new']
    visit edit_image_url(image)
    fill_in 'Image Tags', with: new_tags.join(', ')
    click_on 'Save'
    assert_equal new_tags, Image.find(image.id).tag_list
  end

  test 'filter images' do
    visit images_url
    first_badge = find('a.badge.badge-pill:first-of-type').text
    visit images_url(tag: first_badge)
    assert_selector 'a.badge.badge-pill', text: first_badge
    visit images_url(tag: 'a tag that does not exist')
    refute_selector '.card'
  end

  test 'delete image' do
    images_index_page = PageObjects::ImagesIndexPage.visit
    src = images_index_page.images.first.image_src
    new_images_index_page = images_index_page.images.first.delete!

    refute_equal src, new_images_index_page.images.first&.image_src
    assert_equal PageObjects::ImagesIndexPage, new_images_index_page.class
  end
end

# == Schema Information
#
# Table name: images
#
#  id           :integer          not null, primary key
#  url          :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  lock_version :integer          not null
#

require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test 'should require valid url' do
    image = Image.new
    refute image.valid?
    assert_equal ['can\'t be blank', 'invalid format'], image.errors[:url]
  end

  test 'should have valid url' do
    image = Image.new(url: 'http://appfolio.com')
    assert image.valid?

    image = Image.new(url: 'http://wwww.appfolio.com')
    assert image.valid?

    image = Image.new(url: 'http://host-header.appfolio.com')
    assert image.valid?

    image = Image.new(url: 'https://appfolio.com')
    assert image.valid?

    image = Image.new(url: 'https://appfolio.com/route')
    assert image.valid?

    image = Image.new(url: 'https://appfolio.com/route?query=value')
    assert image.valid?
  end

  test 'should have invalid url' do
    image = Image.new(url: 'a')
    refute image.valid?

    image = Image.new(url: 'httttttp://appfolio.com')
    refute image.valid?

    image = Image.new(url: 'appfolio.com')
    refute image.valid?

    image = Image.new(url: 'www.appfolio.com')
    refute image.valid?

    image = Image.new(url: 'http.www.appfolio.com')
    refute image.valid?
  end

  test 'should save with tags' do
    image = Image.create(url: 'http://appfolio.com', tag_list: 'tag')
    assert_equal image.tag_list[0], 'tag'

    image = Image.create(url: 'http://appfolio.com', tag_list: 'tag with spaces')
    assert_equal image.tag_list[0], 'tag with spaces'

    image = Image.create(url: 'http://appfolio.com', tag_list: 'tag,with,commas')
    assert_equal image.tag_list[0], 'tag'
    assert_equal image.tag_list[1], 'with'
    assert_equal image.tag_list[2], 'commas'

    image = Image.create(url: 'http://appfolio.com', tag_list: ' tag , with , commas and spaces ')
    assert_equal image.tag_list[0], 'tag'
    assert_equal image.tag_list[1], 'with'
    assert_equal image.tag_list[2], 'commas and spaces'
  end
end

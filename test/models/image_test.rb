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
end

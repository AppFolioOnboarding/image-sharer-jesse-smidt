require 'test_helper'

class ShareTest < ActiveSupport::TestCase
  test 'should require email' do
    share = Share.new
    refute share.valid?
    assert_equal ['can\'t be blank', 'invalid format'], share.errors[:email]
  end

  test 'should have valid email' do
    share = Share.new(email: 'test@appfolio.com')
    assert share.valid?
  end

  test 'should have invalid email' do
    share = Share.new(email: '')
    refute share.valid?

    share = Share.new(email: 'a')
    refute share.valid?

    share = Share.new(email: '@.com')
    refute share.valid?

    share = Share.new(email: '@appfolio.com')
    refute share.valid?
  end
end

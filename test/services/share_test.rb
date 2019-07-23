require 'test_helper'

class ShareFormTest < ActiveSupport::TestCase
  test 'should require email' do
    share_form = ShareForm.new
    refute share_form.valid?
    assert_equal ['can\'t be blank', 'invalid format'], share_form.errors[:email]
  end

  test 'should have valid email' do
    share_form = ShareForm.new(email: 'test@appfolio.com')
    assert share_form.valid?
  end

  test 'should have invalid email' do
    share_form = ShareForm.new(email: '')
    refute share_form.valid?

    share_form = ShareForm.new(email: 'a')
    refute share_form.valid?

    share_form = ShareForm.new(email: '@.com')
    refute share_form.valid?

    share_form = ShareForm.new(email: '@appfolio.com')
    refute share_form.valid?
  end
end

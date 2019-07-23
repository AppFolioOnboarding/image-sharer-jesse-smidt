require 'test_helper'

class SharesControllerTest < ActionDispatch::IntegrationTest
  include ActionMailer::TestHelper
  setup do
    @image = Image.first
  end

  test 'should display new share form' do
    get new_image_share_path(@image)

    assert_response :success
    assert_select 'img.display-image'
    assert_select 'input#share_form_email'
    assert_select 'textarea#share_form_message'
    assert_select 'input[type=?]', 'submit'
  end

  test 'should send share email' do
    assert_emails 1 do
      post image_shares_url(@image), params: { share_form: { email: 'no-send@appfolio.com' } }
    end

    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal 'You have sent an image to no-send@appfolio.com', flash[:notice]
  end

  test 'should validate email' do
    post image_shares_url(@image), params: { share_form: { email: 'bad' } }

    assert_response :success
    assert_select 'ul.text-danger li', text: 'Email invalid format'
  end

  test 'should require email' do
    post image_shares_url(@image), params: { share_form: { email: '' } }

    assert_response :success
    assert_select 'ul.text-danger li', text: 'Email can\'t be blank'
  end
end

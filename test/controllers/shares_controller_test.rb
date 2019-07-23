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
  end
end

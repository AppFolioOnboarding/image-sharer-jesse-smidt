require 'test_helper'

class SharesControllerTest < ActionDispatch::IntegrationTest
  include ActionMailer::TestHelper

  test 'should send share email' do
    assert_emails 1 do
      post image_shares_url(Image.first), params: { share: { email: 'no-send@appfolio.com' } }
    end
  end
end

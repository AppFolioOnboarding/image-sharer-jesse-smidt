require 'test_helper'

class ImageShareMailerFlowTest < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome
  include ActionMailer::TestHelper

  test 'share email' do
    visit new_image_share_url(Image.first)
    fill_in 'Email', with: 'no-send@appfolio.com'
    assert_emails 1 do
      click_on 'Share'
    end
  end
end

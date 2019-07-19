require 'test_helper'

class ImageShareMailerTest < ActionMailer::TestCase
  setup do
    share = Share.new email: 'send-to@appfolio.com', message: 'message'
    image = Image.new url: 'https://learn.appfolio.com/apm/www/images/apm-logo-v2.png'
    @email = ImageShareMailer.share_email share: share, image: image, linkback_url: 'https://appfolio.com'

    assert_emails 1 do
      @email.deliver_now
    end
  end

  test 'should have correct meta information' do
    assert_equal ['no-reply@appfolio.com'], @email.from
    assert_equal ['send-to@appfolio.com'], @email.to
    assert_equal 'Someone has invited you to Image Sharer', @email.subject
  end

  test 'should send share email with message' do
    # stripping out all whitespace when comparing email to fixture
    assert_equal read_fixture('share_email.html').join.gsub(/\s+/, ''),
                 @email.html_part.body.to_s.gsub(/\s+/, '')
    assert_equal read_fixture('share_email.txt').join, @email.text_part.body.to_s
  end

  test 'should send share email without message' do
    refute_match @email.html_part.body.to_s, 'They also included this message:'
    refute_match @email.text_part.body.to_s, 'They also included this message:'
  end
end

# Preview all emails at http://localhost:3000/rails/mailers/image_share_mailer
class ImageShareMailerPreview < ActionMailer::Preview
  def share_email
    share = Share.new email: 'no-reply@appfolio.con', message: 'message'
    image = Image.new url: 'https://learn.appfolio.com/apm/www/images/apm-logo-v2.png'
    ImageShareMailer.share_email share: share, image: image, linkback_url: 'https://appfolio.com'
  end
end

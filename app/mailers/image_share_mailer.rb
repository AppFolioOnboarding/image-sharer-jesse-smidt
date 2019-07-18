class ImageShareMailer < ApplicationMailer
  default from: 'no-reply@appfolio.com'
  layout 'mailer'

  def share_email(share:, image:, linkback_url:)
    @share = share
    @image = image
    @linkback_url = linkback_url
    mail to: share.email,
         subject: 'Someone has invited you to Image Sharer'
  end
end

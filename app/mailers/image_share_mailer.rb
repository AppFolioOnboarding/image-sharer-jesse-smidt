class ImageShareMailer < ApplicationMailer
  default from: 'no-reply@appfolio.com'
  layout 'mailer'

  def share_email(share_form:, image:, linkback_url:)
    @share_form = share_form
    @image = image
    @linkback_url = linkback_url
    mail to: share_form.email,
         subject: 'Someone has invited you to Image Sharer'
  end
end

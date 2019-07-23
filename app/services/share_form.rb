class ShareForm
  include ActiveModel::Model

  attr_accessor :email, :message

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'invalid format' }
end

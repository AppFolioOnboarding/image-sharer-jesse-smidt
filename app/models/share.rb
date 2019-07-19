class Share
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_reader :email, :message

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'invalid format' }

  def initialize(email: nil, message: nil)
    @email = email
    @message = message
  end

  def persisted?
    false
  end
end

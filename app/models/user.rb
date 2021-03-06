require 'dm-validations'

class User
  include DataMapper::Resource

  property :id,  Serial
  property :name, String
  property :email, String, format: :email_address, required: true
  property :password_digest, BCryptHash

  attr_accessor :password_confirmation
  attr_reader :password

  validates_confirmation_of :password, confirm: :password_confirmation
  validates_format_of :email, as: :email_address

  def password=(password)
    @password = password
    pass = BCrypt::Password.create(password)
    self.password_digest = pass
  end
end

require 'dm-validations'

class User
  include DataMapper::Resource

  property :id,  Serial
  property :name, String
  property :email, String, format: :email_address, required: true, unique: true
  property :password_digest, BCryptHash
  property :password_token, Text
  property :token_time_generated, Time

  attr_accessor :password_confirmation
  attr_reader :password

  validates_confirmation_of :password

  def password
    @password ||= BCrypt::Password.new(password_digest)
  end

  def password=(password)
    @password = BCrypt::Password.create(password)
    self.password_digest = @password
  end

  def update_password(pass, pass_confirmation)
    self.password = pass
    self.password_confirmation = pass_confirmation
    self.save!
  end

  def authenticate(password)
    self.id if self.password == password
  end

  def expired_token?
    !!((Time.now - self.token_time_generated) > 3600)
  end

  def forgot_password
    random_password = SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz')
    self.password_token = random_password
    self.token_time_generated = Time.now
    self.save!
    #Mailer.create_and_deliver_password_change(self, random_password)
  end

end

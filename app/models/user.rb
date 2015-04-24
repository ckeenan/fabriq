class User < ActiveRecord::Base
	attr_accessible :name, :email, :reputation, :password, :password_confirmation
	has_secure_password

	before_save { self.email = email.downcase }
	before_create :create_remember_token
  before_create :populate_rep
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
    validates :password, length: { minimum: 5 }
    validates :password_confirmation, presence: true

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def populate_rep
    self.reputation = 1
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end
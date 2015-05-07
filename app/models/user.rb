class User < ActiveRecord::Base
	attr_accessible :name, :email, :reputation, :avatar, :password, :password_confirmation, :tribe_id
  belongs_to :tribes
	has_secure_password
  mount_uploader :avatar, AvatarUploader

	before_save { self.email = email.downcase }
  before_create :add_reputation
	before_create :create_remember_token
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  def add_reputation
    if self.reputation == nil
      self.reputation = 0
    end
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end
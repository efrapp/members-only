class User < ApplicationRecord

  before_create :generate_remember_token

  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true

  has_secure_password
  validates :password, presence: true, length: {minimum: 5}, allow_nil: true

  class << self
    def digest(token)
      # I had to comment this option to create digest password because
      # the generated hash in the fixture for users doesn't match using
      # the authenticate method of has_secure_password with the password
      # saved in the databse
      
      # Digest::SHA1.hexdigest(token.to_s)

      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      
      BCrypt::Password.create(token, cost: cost)
    end
  end

  private

    def generate_remember_token
      token = SecureRandom.urlsafe_base64
      self.remember_token = User.digest(token)
    end
end

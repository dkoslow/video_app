class User < ActiveRecord::Base
  before_create :create_auth_token

  validates :first_name, presence: true, length: { maximum: 25 }
  validates :last_name, presence: true, length: { maximum: 25 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  has_secure_password

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_auth_token
      self.auth_token = User.encrypt(SecureRandom.urlsafe_base64)
    end
end

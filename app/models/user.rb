class User < ActiveRecord::Base
  validates :email,
            :password_digest,
            :session_token,
            presence: true,
            uniqueness: true

  after_initialize :ensure_session_token

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    return nil if user.nil?

    user.is_password?(password) ? user : nil
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64(16)
    self.save!
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  private
    def ensure_session_token
      self.session_token ||= SecureRandom::urlsafe_base64(16)
    end


end

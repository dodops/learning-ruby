class User < ActiveRecord::Base

  before_create :generate_authentication_token!

  validates_uniqueness_of :auth_token

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         # LogIn/SignUp via facebook, inicialmente
         :omniauthable, omniauth_providers: [:facebook]

  attachment :profile_image

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

  def password_required?
    super && provider.blank?
  end

  class << self
    def from_omniauth(auth)
      where(provider: auth['provider'], uid: auth['uid']).first_or_create do |user|
        user.email = auth['info']['email']
        user.profile_image = open(URI.parse(auth['info']['image']).to_s)
        user.first_name = auth['info']['first_name']
        user.last_name = auth['info']['last_name']
        user.password = Devise.friendly_token[0, 20]
      end
    end

    def new_with_session(params, session)
      super.tap do |user|
        if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
          user.email = data['email'] if user.email.blank?
        end
      end
    end
  end

end

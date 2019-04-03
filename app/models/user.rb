class User < ApplicationRecord
  # REFERENCED: referenced: https://github.com/RubySource/rails_simple_user_auth

  # reference destinations
  has_many :destinations

  # set access points
  attr_accessor :password

  # define validations
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :uniqueness => true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_digest, :confirmation => true #password_confirmation attr
  validates_length_of :password_digest, :in => 6..20, :on => :create

  # authenticate user
  def self.authenticate(username_or_email="", login_password="")
    if User.find_by_email(username_or_email)
      user = User.find_by_email(username_or_email)
    else
      user = User.find_by_username(username_or_email)
    end
    if user && user.match_password(login_password)
      return user
    else
      return false
    end
  end

  # encrypt password
  has_secure_password
end

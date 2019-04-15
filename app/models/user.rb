class User < ApplicationRecord
  # REFERENCED: referenced: https://github.com/RubySource/rails_simple_user_auth

  # reference destinations
  has_many :destinations

  # define validations
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :uniqueness => true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, :confirmation => true #password_confirmation attr
  validates_length_of :password, :in => 6..20, :on => :create

  # encrypt password
  has_secure_password
end

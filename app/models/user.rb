class User < ActiveRecord::Base
  has_many :cart_ids
  has_many :products, through: :cart_ids
  validates :name, presence: true
  validates :email, presence: true
  validates :address, presence: true
  validates :password, presence: true
  has_secure_password
  include Slugify
  include FormValidator
end

class Admin < ActiveRecord::Base
  has_many :products
  has_secure_password
  include Slugify
end
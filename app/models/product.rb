class Product < ActiveRecord::Base
  has_many :cart_ids
  has_many :users, through: :cart_ids
  validates :name, presence: true
  validates :price, presence: true

  include Slugify
end

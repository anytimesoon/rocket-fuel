class Product < ActiveRecord::Base
  has_many :cartlines
  has_many :cart_ids, through: :cartlines
  belongs_to :admin
  validates :name, presence: true
  validates :price, presence: true

  include Slugify
end

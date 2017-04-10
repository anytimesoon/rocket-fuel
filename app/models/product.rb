class Product < ActiveRecord::Base
  has_many :cartlines
  has_many :cart_ids, through: :cartlines
  belongs_to :admin
  validates :name, presence: true
  validates :price, presence: true

  include Slugify

  def decimal_price
    '%.2f' % price
  end
end

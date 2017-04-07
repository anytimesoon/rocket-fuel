class Cart < ActiveRecord::Base
  belongs_to :users
  has_many :cartlines
  has_many :products, through: :cartlines
end

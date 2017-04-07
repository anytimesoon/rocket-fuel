class Cartline < ActiveRecord::Base
  belongs_to :carts
  belongs_to :products
end

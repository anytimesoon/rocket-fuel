class Cart < ActiveRecord::Base
  belongs_to :carts
  belongs_to :products
end
class Cart < ActiveRecord::Base
  belongs_to :users
  has_many :cartlines
  has_many :products, through: :cartlines

  def decimal_total
    '%.2f' % total
  end
end

class CreateCartlines < ActiveRecord::Migration[5.0]
  def change
    create_table :cartlines do |t|
      t.integer :product_id
      t.integer :cart_id
      t.integer :product_amount
    end
  end
end

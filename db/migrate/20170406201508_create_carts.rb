class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.integer :product_id
      t.integer :user_id
      t.float :total
      t.integer :product_amount
    end
  end
end

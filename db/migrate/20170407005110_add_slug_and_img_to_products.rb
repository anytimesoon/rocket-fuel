class AddSlugAndImgToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :slug, :string
    add_column :products, :img, :string
  end
end

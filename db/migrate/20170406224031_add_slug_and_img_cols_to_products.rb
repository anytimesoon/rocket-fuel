class AddSlugAndImgColsToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :img, :string
    add_column :products, :slug, :string
  end
end

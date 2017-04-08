class CreateAdmin < ActiveRecord::Migration[5.0]
  def change
    create_table :admin do |t|
      t.string :name
      t.string :password_digest
    end
  end
end

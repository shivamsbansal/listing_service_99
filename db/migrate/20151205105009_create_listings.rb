class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :user
      t.integer :price
      t.string :listing_type
      t.integer :postal_code
      t.string :status

      t.timestamps null: false
    end
  end
end

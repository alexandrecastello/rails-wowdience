class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.integer :zipcode
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end

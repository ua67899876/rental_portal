class AddTableApartments < ActiveRecord::Migration[5.2]
  def change
    create_table :apartments do |t|
      t.integer :apartment_type, null: false, default: 0
      t.decimal :rent, null: false, default: 0, scale: 2, precision: 8
      t.string :location, null: false, default: ""
      t.references :owner, null: false, foreign_key: { to_table: 'users' }

      t.timestamps null: false
    end
  end
end

class AddTableDeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :deeds do |t|
      t.integer :deed_type, null: false, default: 0
      t.date :starts_on, null: false
      t.date :ends_on, null: false
      t.references :apartment, foreign_key: true
      t.references :owner, null: false, foreign_key: { to_table: 'users' }
      t.references :renter, foreign_key: { to_table: 'users' }
      
      t.timestamps null: false
    end
  end
end

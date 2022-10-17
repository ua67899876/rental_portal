class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|

      t.references :requester, null: false, foreign_key: { to_table: 'users' }
      t.references :moderator, null: false, foreign_key: { to_table: 'users' }
      t.references :apartment, null: false, foreign_key: true

      t.datetime :start_at
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end

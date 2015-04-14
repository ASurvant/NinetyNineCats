class CreateCatRentalRequests < ActiveRecord::Migration
  def change
    create_table :cat_rental_requests do |t|
      t.integer :cat_id, presence: true, null: false
      t.date :start_date, presence: true, null: false
      t.date :end_date, presence: true, null: false
      t.string :status, default: "PENDING", presence: true, null: false

      t.timestamps
    end

    add_index :cat_rental_requests, :cat_id
  end
end

class AddTimeStampsToCats < ActiveRecord::Migration
  def change
    change_table :cats do |t|
      t.timestamps
    end
  end
end

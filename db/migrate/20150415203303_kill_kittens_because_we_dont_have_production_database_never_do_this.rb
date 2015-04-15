class KillKittensBecauseWeDontHaveProductionDatabaseNeverDoThis < ActiveRecord::Migration
  def change
    remove_column :cats, :user_id
    add_column :cats, :user_id, :integer, null: false
    add_index :cats, :user_id
  end
end

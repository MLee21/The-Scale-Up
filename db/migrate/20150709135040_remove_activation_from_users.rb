class RemoveActivationFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :activated
    remove_column :users, :activated_at
    remove_column :users, :activation_digest
  end

  def down
    add_column :users, :activated, :boolean, default: false
    add_column :users, :activated_at, :datetime
    add_column :users, :activation_digest, :string
  end
end

class AddEmailActivatedtoUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email_activated, :boolean, :default => false
  end
end

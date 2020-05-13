class CreateUserConnections < ActiveRecord::Migration[5.2]
  def change
    create_table :user_connections, :force => true, :id => false do |t|
      t.integer "user_a_id", :null => false
      t.integer "user_b_id", :null => false
    end
  end
end

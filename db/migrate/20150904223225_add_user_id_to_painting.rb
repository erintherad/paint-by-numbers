class AddUserIdToPainting < ActiveRecord::Migration
  def change
    add_column :paintings, :user_id, :integer
  end
end

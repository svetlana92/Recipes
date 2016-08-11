class AddUserToComments < ActiveRecord::Migration[5.0]
  def change
    remove_column :comments, :commenter, :string
    add_reference :comments, :user, index: true, foreign_key: true
  end
end

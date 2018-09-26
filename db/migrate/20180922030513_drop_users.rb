require_relative '20180228205537_create_users'
class DropUsers < ActiveRecord::Migration[5.1]
  def change
    revert CreateUsers
  end
end

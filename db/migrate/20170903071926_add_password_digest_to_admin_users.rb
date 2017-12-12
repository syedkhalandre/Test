class AddPasswordDigestToAdminUsers < ActiveRecord::Migration
  def up
  	remove_column "admin_users", "hashed_password"
  	add_column "admin_users", "password_digest", :string
  end

  def down
  	remove_column "admin_users", "hashed_password", :string, :limit => 40
  	add_column "admin_users", "password_digest"
  end

end

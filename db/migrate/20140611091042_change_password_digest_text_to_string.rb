class ChangePasswordDigestTextToString < ActiveRecord::Migration
  def change
    change_column :users, :password_digest, :string
  end
end

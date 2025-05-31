class RemovePasswordFromUsers < ActiveRecord::Migration[8.0]
  def change
    # Deviseが利用するencrypted_passwordカラムを削除
    remove_column :users, :encrypted_password, :string

    # 他にpassword関連のカラムがあれば削除を追加
    remove_column :users, :reset_password_token, :string
    remove_column :users, :reset_password_sent_at, :datetime
  end
end

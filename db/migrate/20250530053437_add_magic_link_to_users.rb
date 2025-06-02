class AddMagicLinkToUsers < ActiveRecord::Migration[8.0]
  def change
    # カラムが存在しない場合のみ追加
    unless column_exists?(:users, :magic_link_token)
      add_column :users, :magic_link_token, :string
    end
    unless column_exists?(:users, :magic_link_token_sent_at)
      add_column :users, :magic_link_token_sent_at, :datetime
    end
  end
end

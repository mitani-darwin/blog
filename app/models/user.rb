class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  # Magic Linkフィールドを追加
  #  attr_accessor :magic_link_token, :magic_link_token_sent_at

  # トークンが有効かチェック
  def magic_link_token_valid?
    magic_link_token_sent_at > 15.minutes.ago
  end

  # パスワードのバリデーションをスキップする
  def password_required?
    false
  end
end

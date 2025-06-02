class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Devise バリデーションを無効にする
  validates :password, presence: false
  validates :encrypted_password, presence: false

  # トークンが有効かチェック
  def magic_link_token_valid?
    magic_link_token_sent_at > 15.minutes.ago
  end

  # パスワードのバリデーションをスキップする
  def password_required?
    false
  end

  # メールアドレスのバリデーションのみ維持
  def email_required?
    true
  end

end

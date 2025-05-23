class Post < ApplicationRecord
  # バリデーション
  validates :title, presence: true    # タイトルは必須
  validates :content, presence: true  # 本文は必須
  validates :author, presence: true   # 著者は必須
  has_many_attached :images           # 複数の画像を保持する

  # スコープ（例: 公開された記事のみを取得）
  scope :published, -> { where(is_published: true) }
end

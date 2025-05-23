class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false            # 記事のタイトル
      t.text :content, null: false            # 記事の内容
      t.string :author, null: false           # 著者名
      t.datetime :published_at                # 公開日時
      t.boolean :is_published, default: false # 公開状態（デフォルトは非公開）
      t.timestamps
    end
  end
end

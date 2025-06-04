class DropAllTables < ActiveRecord::Migration[8.0]
  def up
    # 外部キー制約を無視してテーブルを削除
    connection.tables.each do |table|
      drop_table table, force: :cascade
    end
  end

  def down
    # downメソッドは空にしておく（元に戻せないため）
    raise ActiveRecord::IrreversibleMigration
  end

end

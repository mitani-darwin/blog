class DropApplicationTables < ActiveRecord::Migration[8.0]
  def up
    # Railsシステムテーブルを除外
    excluded_tables = %w[schema_migrations ar_internal_metadata]

    # アプリケーションテーブルのみを削除
    (connection.tables - excluded_tables).each do |table|
      drop_table table, force: :cascade
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
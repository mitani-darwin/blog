class DropPostsTable < ActiveRecord::Migration[8.0]
  def up
    drop_table :posts if table_exists?(:posts)
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

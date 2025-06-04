namespace :db do
  desc "Drop all application tables (keeping Rails system tables)"
  task drop_app_tables: :environment do
    excluded_tables = %w[schema_migrations ar_internal_metadata]

    connection = ActiveRecord::Base.connection
    app_tables = connection.tables - excluded_tables

    if app_tables.empty?
      puts "No application tables to drop."
    else
      puts "Dropping the following tables:"
      app_tables.each { |table| puts "  - #{table}" }

      app_tables.each do |table|
        connection.drop_table(table, force: :cascade)
        puts "Dropped: #{table}"
      end

      puts "All application tables have been dropped."
    end
  end
end
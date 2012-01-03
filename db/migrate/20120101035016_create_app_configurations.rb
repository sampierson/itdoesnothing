class CreateAppConfigurations < ActiveRecord::Migration
  def change
    create_table :app_configurations do |t|
      t.integer :site_availability, :default => 100 # Fully operational
      t.string :maintenance_message
    end
  end
end

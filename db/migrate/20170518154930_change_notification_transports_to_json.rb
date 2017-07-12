class ChangeNotificationTransportsToJson < ActiveRecord::Migration[5.1]
  def change
    remove_column :notifications, :transports, :string, array: true
    add_column :notifications, :transports, :jsonb, null: false, default: '{}'
  end
end

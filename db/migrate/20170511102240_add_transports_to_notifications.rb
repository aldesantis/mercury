class AddTransportsToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :transports, :string, array: true, default: []
  end
end

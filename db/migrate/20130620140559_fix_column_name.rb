class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :follow_channels, :user_id_id, :user_id
    rename_column :follow_channels, :channel_id_id, :channel_id
  end
end

class CreateFollowChannels < ActiveRecord::Migration
  def change
    create_table :follow_channels do |t|
      t.references :user_id, index: true
      t.references :channel_id, index: true

      t.timestamps
    end
  end
end

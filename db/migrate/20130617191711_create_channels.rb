class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :channel_name
      t.string :description

      t.timestamps
    end
  end
end

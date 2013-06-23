class AddPrivacyToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :privacy, :string
  end
end

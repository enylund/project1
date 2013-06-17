json.array!(@channels) do |channel|
  json.extract! channel, :name, :description, :user_id
  json.url channel_url(channel, format: :json)
end
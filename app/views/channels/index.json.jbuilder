json.array!(@channels) do |channel|
  json.extract! channel, :channel_name, :description
  json.url channel_url(channel, format: :json)
end
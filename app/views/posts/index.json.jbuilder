json.array!(@posts) do |post|
  json.extract! post, :img_url, :caption, :user_id, :channel_id
  json.url post_url(post, format: :json)
end
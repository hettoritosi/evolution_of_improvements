json.array!(@improvements) do |improvement|
  json.extract! improvement, :id, :title, :category, :content, :user_id
  json.url improvement_url(improvement, format: :json)
end

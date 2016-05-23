json.array!(@conferences) do |conference|
  json.extract! conference, :id, :name, :location
  json.url conference_url(conference, format: :json)
end

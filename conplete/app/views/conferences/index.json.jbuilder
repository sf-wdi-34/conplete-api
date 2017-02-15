json.array! @conferences do |conference|
  json.name conference.name
  json.location conference.location
  json.url conference_url(conference)
end

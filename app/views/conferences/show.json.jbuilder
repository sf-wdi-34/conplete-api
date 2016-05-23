json.extract! @conference, :id, :name, :location, :created_at, :updated_at

json.url conference_url(@conference, format: :json)

json.talks do
  json.array!(@conference.talks) do |talk|
    json.title talk.title
    json.speaker_name talk.speaker_name
    json.start_time talk.start_time
    json.end_time talk.end_time
    json.url conference_talk_url(@conference, talk, format: :json)
  end
end

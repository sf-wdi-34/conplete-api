json.array!(@talks) do |talk|
  json.extract! talk, :id, :title, :speaker_name, :start_time, :end_time, :conference_id
  json.url talk_url(talk, format: :json)
end

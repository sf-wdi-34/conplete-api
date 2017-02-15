json.extract! talk, :id, :speaker_name, :title, :start_time, :end_time, :conference_id, :created_at, :updated_at
json.url talk_url(talk, format: :json)
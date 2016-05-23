json.extract! @talk, :id, :title, :speaker_name, :start_time, :end_time, :conference_id, :created_at, :updated_at


json.url conference_talk_url(@conference, @talk, format: :json)

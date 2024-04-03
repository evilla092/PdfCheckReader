json.extract! infraction, :id, :member_id, :note, :passed, :created_at, :updated_at
json.url infraction_url(infraction, format: :json)

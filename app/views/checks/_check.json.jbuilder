json.extract! check, :id, :check_date, :check_amount, :infraction_count, :user_id, :created_at, :updated_at
json.url check_url(check, format: :json)

json.extract! payer, :id, :dues_amount, :cope_amount, :name, :total_wages_earned_pp, :hourly_rate, :check_id, :created_at, :updated_at
json.url payer_url(payer, format: :json)

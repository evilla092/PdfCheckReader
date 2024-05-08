# == Schema Information
#
# Table name: payers
#
#  id                    :integer          not null, primary key
#  cope_amount           :decimal(, )
#  dues_amount           :decimal(, )
#  hourly_rate           :decimal(, )
#  name                  :string
#  total_wages_earned_pp :decimal(, )
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  check_id              :integer          not null
#
# Indexes
#
#  index_payers_on_check_id  (check_id)
#
# Foreign Keys
#
#  check_id  (check_id => checks.id)
#
class Payer < ApplicationRecord
  belongs_to :check
  has_many :employers, through: :check
  has_many :infractions
  # Nitpick: keep spacing consistent! Remove this unnecessary line
end

# == Schema Information
#
# Table name: checks
#
#  id               :integer          not null, primary key
#  check_amount     :decimal(, )      not null
#  check_date       :date             not null
#  infraction_count :integer          default(0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  employer_id      :integer          not null
#  user_id          :integer          not null
#
# Indexes
#
#  index_checks_on_employer_id  (employer_id)
#  index_checks_on_user_id      (user_id)
#
# Foreign Keys
#
#  employer_id  (employer_id => employers.id)
#  user_id      (user_id => users.id)
#
class Check < ApplicationRecord
  belongs_to :user
  belongs_to :employer
  has_many :payers
  has_many :infractions
end

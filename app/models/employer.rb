# == Schema Information
#
# Table name: employers
#
#  id         :integer          not null, primary key
#  dues_rate  :decimal(5, 2)
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_employers_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Employer < ApplicationRecord
  belongs_to :user
  has_many :checks
  has_many :payers, through: :checks
end

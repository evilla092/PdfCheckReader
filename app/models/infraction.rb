# == Schema Information
#
# Table name: infractions
#
#  id         :integer          not null, primary key
#  note       :string
#  passed     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  payer_id   :integer
#
# Indexes
#
#  index_infractions_on_payer_id  (payer_id)
#
# Foreign Keys
#
#  payer_id  (payer_id => payers.id)
#
class Infraction < ApplicationRecord
  belongs_to :payer
end

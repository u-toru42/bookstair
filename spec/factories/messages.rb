# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  content    :text
#  published  :datetime
#  sender     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :message do
    published { "2023-10-07 20:42:19" }
    sender { "MyText" }
    content { "MyText" }
  end
end

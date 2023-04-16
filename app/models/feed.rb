# == Schema Information
#
# Table name: feeds
#
#  id         :bigint           not null, primary key
#  content    :text
#  title      :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Feed < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true
end

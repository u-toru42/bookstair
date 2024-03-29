# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tags_on_name  (name) UNIQUE
#
class Tag < ApplicationRecord
  has_many :bookmark_tag_relations, dependent: :destroy
  has_many :bookmarks, through: :bookmark_tag_relations, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  # scope :popular, -> { where(id: BookmarkTagRelation.group(:tag_id).order('count_tag_id desc').limit(5).count(:tag_id).keys) }
end

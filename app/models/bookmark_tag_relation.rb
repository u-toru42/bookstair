# == Schema Information
#
# Table name: bookmark_tag_relations
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  bookmark_id :bigint           not null
#  tag_id      :bigint           not null
#
# Indexes
#
#  index_bookmark_tag_relations_on_bookmark_id             (bookmark_id)
#  index_bookmark_tag_relations_on_tag_id                  (tag_id)
#  index_bookmark_tag_relations_on_tag_id_and_bookmark_id  (tag_id,bookmark_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (bookmark_id => bookmarks.id)
#  fk_rails_...  (tag_id => tags.id)
#
class BookmarkTagRelation < ApplicationRecord
  belongs_to :bookmark
  belongs_to :tag
  
  validates :tag_id, uniqueness: { scope: :bookmark_id }
end

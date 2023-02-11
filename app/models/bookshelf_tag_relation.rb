class BookshelfTagRelation < ApplicationRecord
  belongs_to :bookshelf
  belongs_to :tag
end

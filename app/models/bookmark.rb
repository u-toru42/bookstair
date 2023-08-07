# == Schema Information
#
# Table name: bookmarks
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  book_isbn  :bigint           not null
#  chapter    :text
#  headline   :text             not null
#  link       :text
#  page       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_bookmarks_on_book_isbn  (book_isbn)
#  index_bookmarks_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_isbn => books.isbn)
#  fk_rails_...  (user_id => users.id)
#
class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :book, foreign_key: 'book_isbn'
  has_many :bookmark_tag_relations, dependent: :destroy
  has_many :tags, through: :bookmark_tag_relations

  validates :headline, presence: true, length: { maximum: 300 }
  validates :body, presence: true, length: { maximum: 3000 }
  validates :chapter, allow_blank: true, length: { maximum: 9999 }, numericality: {only_integer: true}
  validates :link, allow_blank: true, length: { maximum: 100 }
  
  before_validation :detect_negative_expressions

  scope :with_tag, ->(tag_name) { joins(:tags).where(tags: { name: tag_name }) }

  def is_mine?(current_user)
    self.user == current_user
  end

  def save_with_tags(tag_names:)
    ActiveRecord::Base.transaction do
      self.tags = tag_names.map { |name| Tag.find_or_initialize_by(name: name.strip) }
      save!
    end
    true
  rescue StandardError
    false
  end

  def tag_names
    # NOTE: pluckだと新規作成失敗時に値が残らない(返り値がnilになる)
    tags.map(&:name).join(',')
  end

  private

  def detect_negative_expressions
    language_service = Google::Cloud::Language.language_service

    # 言語の設定
    document = { content: body, type: :PLAIN_TEXT, language: "ja" }

    # 感情分析のリクエストを作成
    response = language_service.analyze_sentiment document: document

    # ネガティブな表現が含まれている場合は、エラーを追加
    if response.document_sentiment.score < 0
      errors.add(:content, "NGワードが含まれています")
    end
  end

end

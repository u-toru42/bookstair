class Book < ApplicationRecord
  def save_with_author(author)
    ActiveRecord::Base.transaction do
      self.save!
      self.author = author.uniq.reject(&:blank?).map { |name| Author.find_or_initialize_by(name: name.strip) } unless author.nil?
    end
    true
    rescue StandardError
      false
end
end
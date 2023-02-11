# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

    def self.guest
      find_or_create_by!(email: "guest@example.com") do |user|
        user.password = SecureRandom.urlsafe_base64
    end
  end

<<<<<<< Updated upstream
<<<<<<< Updated upstream
  validates :email, uniqueness: true, presence: true
  validates :user_name, presence: true, length: { maximum: 255 }

  has_many :books, through: :bookshelves
  has_many :bookshelves, dependent: :destroy
=======
=======
>>>>>>> Stashed changes
  has_many :books, dependent: :destroy
  has_many :comments, dependent: :destroy

  def my_comment?(comment)
    self == comment.user
  end

  def own?(object)
    id == object.user_id
  end
<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
end

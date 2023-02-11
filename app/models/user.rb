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
<<<<<<< HEAD
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
=======
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true, presence: true
<<<<<<< HEAD
  validates :name, presence: true, length: { maximum: 255 }
>>>>>>> 200e31c (ログイン機能実装(ログアウト機能が未完成))
=======
  validates :user_name, presence: true, length: { maximum: 255 }
>>>>>>> 06b00fa (i18n、decorator、ユーザー名絡む名をname->user_nameに変更)
end

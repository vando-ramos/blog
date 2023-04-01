class Post < ApplicationRecord
  extend FriendlyId

  validates :title, :author, :body, presence: true

  has_many :comments, dependent: :destroy

  friendly_id :title, use: :slugged
end

class Post < ApplicationRecord
  belongs_to :end_user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :genre
  
  validates :name, presence: true
  validates :introduction, presence: :true
end

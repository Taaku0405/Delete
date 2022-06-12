class Group < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :group_users, dependent: :destroy

  has_many :end_users, through: :group_users, source: :end_user

  has_one_attached :group_image

  validates :name, presence: true
  validates :introduction, presence: true

  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end

  def is_owned_by?(end_user)
    owner.id == end_user.id
  end

  def includesUser?(end_user)
    group_users.exists?(end_user_id: end_user.id)
  end

end

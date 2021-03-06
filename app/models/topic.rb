class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :topic_categoryships
  has_many :categories, through: :topic_categoryships
  has_one :photo, dependent: :destroy
  accepts_nested_attributes_for :photo
  has_many :store_topicships
  has_many :stored_users, through: :store_topicships, source: :user
  # has_one :topicphoto
  # accepts_nested_attributes_for :topicphoto

  def find_like(user)
    Like.where(topic_id: self.id, user_id: user.id).first
    # Like.where(topic_id: id, user_id: user.id) #也可以

  end

  def is_like_by(user)
    find_like(user).present?
  end
end

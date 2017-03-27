class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  has_many :topic_categoryships
  has_many :categories, through: :topic_categoryships
end

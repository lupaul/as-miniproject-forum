class Category < ActiveRecord::Base
  has_many :topic_categoryships
  has_many :members, through: :topic_categoryships, source: :topic
end

class Comment < ActiveRecord::Base
  validates :content, presence: true
  belongs_to :topic, counter_cache: :comments_count
  belongs_to :user
  has_one :photo
  accepts_nested_attributes_for :photo
end

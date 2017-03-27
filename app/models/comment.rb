class Comment < ActiveRecord::Base
  validates :content, presence: true
  belongs_to :topic, counter_cache: :comments_count
end

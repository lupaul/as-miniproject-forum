class Photo < ActiveRecord::Base
  # belongs_to :user
  belongs_to :topic
  # belongs_to :comment
  mount_uploader :image, ImageUploader
end

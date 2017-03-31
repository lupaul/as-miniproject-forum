class Topicphoto < ActiveRecord::Base
  belongs_to :topic
  mount_uploader :image, ImageUploader
end

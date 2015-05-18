class Photo < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  belongs_to :place
  # validates :place, presence: true
end

class Place < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :photos, :dependent => :destroy
  
  geocoded_by :address
  after_validation :geocode
  
  validates :name, :address, :description, :presence => true
  validates :name, length: { :minimum => 3, :maximum => 100 }

  def self.search(search)
    where('name LIKE ?', "%#{search}%")
  end
end

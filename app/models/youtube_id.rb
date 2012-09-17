class YoutubeId < ActiveRecord::Base
  attr_accessible :y_id, :name
  
  validates :y_id, :presence => true, :uniqueness => true
end

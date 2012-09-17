class YoutubeId < ActiveRecord::Base
  attr_accessible :y_id, :name
  
  validates :y_id, :presence => true, :uniqueness => true
  
  def extract_youtube_id_from_url()
    # check if url has 'youtube' string
    if self.y_id.strip == ""
      self.errors.add(:y_id, "not a valid url")
      return nil
    end
    
    # check if url has 'youtube' string
    if !self.y_id.include?("youtube.com")
      self.errors.add(:y_id, "not a youtube url")
      return nil
    end
    
    # parse uri
    begin
      tmp_params = URI.parse(self.y_id).query
    rescue URI::InvalidURIError => ex
      self.errors.add(:y_id, "not a valid url")
      return nil
    end
    
    # get query params
    if tmp_params.nil?
      self.errors.add(:y_id, "has no params")
      return nil
    end
    
    # parse query params and get youtube_id
    y_id = CGI.parse(tmp_params)['v']
    if y_id.length == 0
      self.errors.add(:y_id, "hasnot youtube id param")
      return nil
    end
    
    # get video info using Youtube API
    return y_id[0].strip
  end
end

require 'open-uri'

class YoutubeIdsController < ApplicationController
  # GET /youtube_ids
  # GET /youtube_ids.json
  def index
    @youtube_ids = YoutubeId.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @youtube_ids }
    end
  end

  # GET /youtube_ids/1
  # GET /youtube_ids/1.json
  def show
    @youtube_id = YoutubeId.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @youtube_id }
    end
  end

  # GET /youtube_ids/new
  # GET /youtube_ids/new.json
  def new
    @youtube_id = YoutubeId.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @youtube_id }
    end
  end

  # GET /youtube_ids/1/edit
  #def edit
  #  @youtube_id = YoutubeId.find(params[:id])
  #end

  # POST /youtube_ids
  # POST /youtube_ids.json
  def create
    # check if url has 'youtube' string
    if params[:youtube_id][:y_id].strip == ""
      return_new_page("Please input Youtube URL.")
      return
    end
    
    # check if url has 'youtube' string
    if !params[:youtube_id][:y_id].include?("youtube.com")
      return_new_page("This URL is not youtube url. Please try it again.")
      return
    end
    
    # parse uri
    begin
      tmp_params = URI.parse(params[:youtube_id][:y_id]).query
    rescue URI::InvalidURIError => ex
      return_new_page("This URL is invalid url. Please try it again.")
      return
    end
    
    # get query params
    if tmp_params.nil?
      return_new_page("I can't find params from this url. Please try it again.")
      return
    end
    
    # parse query params and get youtube_id
    y_id = CGI.parse(tmp_params)['v']
    if y_id.length == 0
      return_new_page("I can't find id from this url. Please try it again.")
      return
    end
    
    # get video info using Youtube API
    y_id = y_id[0].strip
    
    #g_url = "http://gdata.youtube.com/feeds/api/videos?q=#{y_id}"
    #doc = Nokogiri::HTML(open(g_url))
    
    # for testing
    #docfile = File.open("/work/youtube_g_exist.html", "r")
    #contents = docfile.read
    #doc = Nokogiri::HTML(contents)

    title_obj = doc.search("entry/title").first
    
    if !title_obj.nil?
      title = title_obj.text()
      @youtube_id = YoutubeId.new({:y_id => y_id, :name => title})
      
      respond_to do |format|
        if @youtube_id.save
          format.html { redirect_to new_youtube_id_path, notice: 'Video found.' }
          format.json { render json: @youtube_id, status: :created, location: @youtube_id }
        else
          format.html { render action: "new" }
          format.json { render json: @youtube_id.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        return_new_page("Video not found.")
        return
      end
    end
  end

=begin
  # PUT /youtube_ids/1
  # PUT /youtube_ids/1.json
  def update
    @youtube_id = YoutubeId.find(params[:id])

    respond_to do |format|
      if @youtube_id.update_attributes(params[:youtube_id])
        format.html { redirect_to @youtube_id, notice: 'Youtube was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @youtube_id.errors, status: :unprocessable_entity }
      end
    end
  end
=end

  # DELETE /youtube_ids/1
  # DELETE /youtube_ids/1.json
  def destroy
    @youtube_id = YoutubeId.find(params[:id])
    @youtube_id.destroy

    respond_to do |format|
      format.html { redirect_to youtube_ids_url }
      format.json { head :no_content }
    end
  end
  
  private
  def return_new_page(notice)
    respond_to do |format|
      @youtube_id = YoutubeId.new(params[:youtube_id]) 
      flash[:notice] = notice
      format.html { render "new"}
    end
  end
end

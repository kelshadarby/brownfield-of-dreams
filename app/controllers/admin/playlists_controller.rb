class Admin::PlaylistsController < ApplicationController
  def new
    @tutorial = Tutorial.new
  end

  def create
    next_page_token = ''
    tutorial = Tutorial.create(tutorial_params)
    until next_page_token.nil?
      playlist_info = YoutubeService.new.playlist_info(params[:playlist_id], next_page_token)
      @videos = playlist_info[:items]
      @videos.each do |video|
        if video[:snippet][:thumbnails].nil?
          attributes = {"title" => video[:snippet][:title],
                      "description" => video[:snippet][:description],
                      "thumbnail" => '',
                      "video_id" => video[:contentDetails][:videoId]}
        else
          attributes = {title: video[:snippet][:title],
                  description: video[:snippet][:description],
                  thumbnail: video[:snippet][:thumbnails],
                  video_id: video[:contentDetails][:videoId]}
        end
        tutorial.videos.create(attributes)
      end
      next_page_token = playlist_info[:nextPageToken]
    end

    redirect_to "/admin/dashboard"
    flash[:notice] = "Successfully created tutorial. #{view_context.link_to 'View it here', "/tutorials/#{tutorial.id}"}".html_safe
  end

  private
    def tutorial_params
      params.permit(:title, :description, :thumbnail, :playlist_id)
    end
end

class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
    if !current_user
      flash[:notice] = "User must login to bookmark videos."
    end
  end
end

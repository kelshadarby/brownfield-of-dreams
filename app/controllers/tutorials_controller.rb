class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
    flash[:notice] = 'User must login to bookmark videos.' unless current_user
  end
end

class ProfilesController < ApplicationController
  def edit
    @profile = current_user.profile
  end

  def update
    current_user.profile.update!(score_config: dignity_scores)
    redirect_to :controller => 'planets_dignities', :action => 'new'
  end

  private

  def dignity_scores
    scores = {}
    params[:score_config].each do |dignity, score|
      scores[dignity] = { 'score' => score.to_i }
    end
    scores
  end


end

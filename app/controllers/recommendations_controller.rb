class RecommendationsController < ApplicationController

  before_filter :authenticate

  # PUT /rivers/1/recommendations/1/hide
  def hide
    @river = River.find(params[:river_id])
    @recommendation = @river.recommendations.find(params[:recommendation_id])
    @recommendation.update_attribute(:is_manually_hidden,true)
    @recommendation.update_attribute(:show_in_river,false)
    respond_to do |format|
      format.html { redirect_to @river, notice: 'Recommendation was successfully hidden.' }
      format.js
    end
  end

  # PUT /rivers/1/recommendations/1/toggle_star
  def toggle_star
    @river = River.find(params[:river_id])
    @recommendation = @river.recommendations.find(params[:recommendation_id])

    if @recommendation.is_manually_starred?
      @recommendation.update_attribute(:is_manually_starred,false)
      @manually_starred = false
    else
      @recommendation.update_attribute(:is_manually_starred,true)
      @manually_starred = true
    end

    respond_to do |format|
      format.html { redirect_to @river, notice: 'Recommendation is now starred!' }
      format.js
    end
  end

end

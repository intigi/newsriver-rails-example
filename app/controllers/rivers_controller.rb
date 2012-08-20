class RiversController < ApplicationController

  layout "river", :only => [:show, :starred]

  before_filter :authenticate, :except => [:show, :starred]

  # GET /rivers
  # GET /rivers.json
  def index
    @rivers = River.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rivers }
    end
  end

  # GET /rivers/1
  # GET /rivers/1.atom
  def show
    @river = River.find(params[:id])
    @page_title = @river.title

    @recommendations = @river.recommendations.public.limit(50).order('intigi_found_at desc')

    respond_to do |format|
      format.html # show.html.erb
      format.atom # show.atom.builder
    end
  end

  # GET /rivers/1/starred
  # GET /rivers/1/starred.json
  def starred
    @river = River.find(params[:id])
    @page_title = @river.title

    @recommendations = @river.recommendations.public.starred.order('intigi_found_at desc')

    respond_to do |format|
      format.html { render :action => 'show' }
      format.atom { render :action => 'show' }
    end
  end

 # GET /rivers/1/work
  def work
    @river = River.find(params[:id])

    @new_recommendations, @existing_recommendations = @river.fetch_recommendations_from_intigi

    respond_to do |format|
      format.html # work.html.erb
    end
  end

  # GET /rivers/new
  # GET /rivers/new.json
  def new
    @river = River.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @river }
    end
  end

  # GET /rivers/1/edit
  def edit
    @river = River.find(params[:id])
  end

  # POST /rivers
  # POST /rivers.json
  def create
    @river = River.new(params[:river])

    respond_to do |format|
      if @river.save
        format.html { redirect_to @river, notice: 'River was successfully created.' }
        format.json { render json: @river, status: :created, location: @river }
      else
        format.html { render action: "new" }
        format.json { render json: @river.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rivers/1
  # PUT /rivers/1.json
  def update
    @river = River.find(params[:id])

    respond_to do |format|
      if @river.update_attributes(params[:river])

        # TODO: Only update if @river.intigi_popularity_threshold_changed? || @river.topsy_popularity_threshold_changed?
        @river.recommendations.each do |recommendation|
          recommendation.update_attribute(:show_in_river,true)    if recommendation.meets_popularity_criteria?
          recommendation.update_attribute(:show_in_river,false)   if !recommendation.meets_popularity_criteria?
        end

        format.html { redirect_to @river, notice: 'River was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @river.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rivers/1
  # DELETE /rivers/1.json
  def destroy
    @river = River.find(params[:id])
    @river.destroy

    respond_to do |format|
      format.html { redirect_to rivers_url }
      format.json { head :no_content }
    end
  end
end

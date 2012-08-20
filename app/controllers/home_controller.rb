class HomeController < ApplicationController

  layout "river"

  # GET /
  def index
    @rivers = River.featured

    @page_title = @rivers.empty? ? "Welcome" : River.featured.first.title

    respond_to do |format|
      format.html # index.html.haml
    end
  end

end

class SearchController < ApplicationController
  def index
  end

  def search
    keywords = params[:keywords].split(",").map(&:strip)
    finder = Finder.new(keywords: keywords)
    @results = finder.find_matches

    respond_to do |format|
      format.turbo_stream
      format.html {}
    end
  end
end

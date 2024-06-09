class FindingsController < ApplicationController
  def index
  end

  def create
    keywords = params[:keywords].split(",").map(&:strip)
    finder = Finder.new(keywords: keywords)
    @results = finder.find_matches
    # Reverse the order of the results so that the most recent Ruby Weekly issues
    # come first because it's currently scraped from the oldest to the most recent.
    # Not ideal, but we can worry about it later.
    @results.reverse

    respond_to do |format|
      format.turbo_stream
      format.html {}
    end
  end
end

class FindingsController < ApplicationController
  def index
  end

  def create
    keywords = sanitize_keywords(findings_params[:keywords])

    # We don't store findings yet so just logging for fun and insights:
    logger.info("SESSION #{session.id} searched for #{keywords}")

    if keywords.empty?
      Sentry::Metrics.increment("something_found")

      flash.now.alert = "Please enter at least one keyword."
      render :index, status: :unprocessable_entity
    else
      Sentry::Metrics.increment("nothing_found")

      finder = Finder.new(keywords: keywords)
      @results = finder.find_matches
      @results.reverse

      respond_to do |format|
        format.turbo_stream
      end
    end
  end

  private

  def findings_params
    params.require(:findings).permit(:keywords)
  end

  def sanitize_keywords(keywords)
    keywords.split(",").map { |keyword| ActionController::Base.helpers.sanitize(keyword.strip) }.reject(&:blank?)
  end
end

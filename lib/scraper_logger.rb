require "logger"

# This guy will log to the console and to a file. Even more useful if you want to keep an eye on
# the scraping progress in the console when slow requests are involved.
class ScraperLogger
  def self.logger(file = "scraper.log")
    unless @logger
      # Logger for STDOUT
      stdout_logger = ActiveSupport::Logger.new($stdout)
      stdout_logger.formatter = Logger::Formatter.new

      # Logger for file
      file_logger = Logger.new(Rails.root.join("log", file))
      file_logger.formatter = Logger::Formatter.new

      tagged_stdout_logger = ActiveSupport::TaggedLogging.new(stdout_logger)
      tagged_file_logger = ActiveSupport::TaggedLogging.new(file_logger)

      # Combine both loggers
      @logger = ActiveSupport::BroadcastLogger.new(tagged_stdout_logger, tagged_file_logger)

      @logger.stop_broadcasting_to(tagged_file_logger) if ENV["NO_LOG"] == "true"
    end

    @logger
  end
end

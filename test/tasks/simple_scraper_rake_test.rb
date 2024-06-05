require "test_helper"
require "rake"

class SimpleScraperRakeTest < ActiveSupport::TestCase
  def setup
    Rake.application.rake_require "tasks/simple_scraper"
    Rake::Task.define_task(:environment)
  end

  def test_valid_url
    ENV["BASE_URL"] = "http://example.com"
    ENV["FROM"] = "1"
    ENV["TO"] = "10"

    SimpleScraper.expects(:new).with(ENV["BASE_URL"], ENV["FROM"], ENV["TO"])
    SimpleScraper.any_instance.expects(:crawl)

    Rake::Task["scraper:run"].invoke
  end

  def test_invalid_url
    ENV["BASE_URL"] = "invalid_url"

    assert_raises(SystemExit) do
      assert_output(/Invalid BASE_URL/) { Rake::Task["scraper:run"].invoke }
    end
  end

  def test_invalid_scheme
    ENV["BASE_URL"] = "ftp://example.com"

    assert_raises(SystemExit) do
      assert_output(/Invalid BASE_URL/) { Rake::Task["scraper:run"].invoke }
    end
  end
end

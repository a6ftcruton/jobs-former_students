require 'minitest/autorun'
require 'minitest/pride'
require './lib/jobs/former_students/scraper'
require 'mechanize'

class ScraperTest < Minitest::Test

  def test_it_exists
    assert Jobs::FormerStudents::Scraper
  end

  def test_it_returns_company_name
    scraper = Jobs::FormerStudents::Scraper.new
    results = scraper.get_company_name(12)
    assert_equal ["Acumen Digital"], results 
  end

  def test_it_stores_all_uniq_company_names
    scraper = Jobs::FormerStudents::Scraper.new
  end

  def test_it_returns_valid_responses_only
    scraper = Jobs::FormerStudents::Scraper.new
    result = scraper.get_company_name(2) # this page does not exist
    assert_equal [], result 
  end

  def test_it_handles_nil_errors
    scraper = Jobs::FormerStudents::Scraper.new
    result = scraper.get_company_name(80) # this page exists but with no information
    assert_equal [], result
  end

  def test_it_creates_array_of_company_names
    scraper = Jobs::FormerStudents::Scraper.new
    results = scraper.get_all_company_names(90) # this page exists but with no information
    refute results.nil?
    assert results.kind_of?(Array)
  end
end

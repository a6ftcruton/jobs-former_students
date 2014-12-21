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

  def test_it_returns_empty_array_if_matching_selector_is_not_on_page
    scraper = Jobs::FormerStudents::Scraper.new
    result = scraper.get_company_name(80) # this page exists but with no information 
    assert_equal [], result 
  end

  def test_it_returns_empty_string_if_matching_selector_is_not_on_page
    scraper = Jobs::FormerStudents::Scraper.new
    result = scraper.get_company_name(2) # this page does not exist
    assert_equal [], result 
  end

  def test_it_creates_array_of_company_names
    scraper = Jobs::FormerStudents::Scraper.new
    results = scraper.get_unique_company_names(90) # Searches '/students/1' through '/students/90' 
    refute results.nil?
    assert results.kind_of?(Array)
    refute results.any? { |result| result.empty?}
  end

  def test_it_returns_only_unique_names
    scraper = Jobs::FormerStudents::Scraper.new
    results = scraper.get_unique_company_names(30) # There are 3 students at Zayo in this search group 
    zayo = results.find_all {|co| co == "Zayo" }
    refute zayo.count > 1 
  end

  def test_it_returns_sorted_list_of_companies_by_count
    scraper = Jobs::FormerStudents::Scraper.new
    results = scraper.sort_companies_by_count(80) # There are 4 students at Zayo in this search group 
    assert_equal 4, results # Zayo?
  end
end

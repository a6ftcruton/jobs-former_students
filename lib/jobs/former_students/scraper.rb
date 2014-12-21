require 'mechanize'

module Jobs
  module FormerStudents
    class Scraper
      attr_reader :companies

      def initialize
        @companies = [] 
      end

      def get_company_name(student_number)
        agent = Mechanize.new
        base_uri = 'https://students.gschool.it/students/'
        page = agent.get( base_uri + "#{student_number}" )

        company = page.at('.hero-subtitle > h3').text.strip
        companies.push(company) unless company.empty?
        puts "Company at /students/" + "#{student_number} is: " + "#{company}" 
        companies
        rescue Mechanize::ResponseCodeError
          puts "404 error at #{base_uri}" + "#{student_number}"
          return companies
      end

      def get_all_company_names(uri_range_end)
        i = 1
        until i == uri_range_end
          get_company_name(i)
          i += 1
        end
        companies.find_all { |co| !co.empty? }
      end

      def get_unique_company_names(uri_range_end)
        get_all_company_names(uri_range_end).uniq
      end

      def sort_companies_by_count(uri_range_end)
        results = get_all_company_names(uri_range_end)
        results.group_by { |co| co }
      end
    end
  end
end


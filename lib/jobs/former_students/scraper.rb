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
      end

      def get_all_company_names(uri_range_end)
        i = 1
        until i == uri_range_end
          get_company_name(i)
          i += 1
        end
        puts companies.find_all { |co| !co.empty? }.uniq
      end
    end
  end
end


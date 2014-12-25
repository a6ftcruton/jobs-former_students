require 'mechanize'

module Jobs
  module FormerStudents
    class Scraper
      attr_reader :companies, :agent

      def initialize
        @companies = [] 
        @agent = Mechanize.new
      end

      def url_to_scrape(uri)
        base_url = 'https://students.gschool.it/students/'
        agent.get( base_url + "#{uri}" )
      end

      def get_company_name(student_number)
        page = url_to_scrape(student_number)
        company_name = page.at('.hero-subtitle > h3').text.strip
        companies.push(company_name) unless company_name.empty?
        puts "Company at /students/" + "#{student_number} is: " + "#{company_name}" 
        companies
        rescue Mechanize::ResponseCodeError
          puts "404 error at /students" + "#{student_number}"
          return companies
      end

      def get_company_names(total_students)
        i = 1
        until i == total_students
          get_company_name(i)
          i += 1
        end
        companies.find_all { |co| !co.empty? }
      end

      def get_unique_company_names(total_students)
        get_company_names(total_students).uniq
      end

      def total_students_employed_per_company(total_students)
        companies = get_company_names(total_students)
        companies.inject(Hash.new(0)) do |h,v| 
          h[v] += 1 
          h 
        end 
      end

      def sort_by_frequency(total_students)
        frequency = total_students_employed_per_company(total_students)
        frequency.sort_by { |k,v| v }.reverse
      end

    end
  end
end


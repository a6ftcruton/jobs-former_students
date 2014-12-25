# Jobs::FormerStudents

This is a small gem intended for use with the [Turing School]('https://turing.io') jobs-basket gem. It returns a list of all companies that have employed or currently employ former gSchool students as indicated by the gSchool website. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jobs-former_students'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jobs-former_students

## Basic Usage
This gem provides instance methods to return single company names or an array of all company names. Start by creating a new instance of the Scraper class: 
 ```ruby
 scraper = Scraper.new
 ```
To return a full, current list of company names, pass in a range limit to the #get_company_names method:
```ruby
  scraper.get_company_names(80)
```

The above method will search 80 students. As of the publishing date of this Version 0.0.1 of this gem, student 65 is the last student with a valid company name. Pages after this represent either pages that do not exist or students who have incomplete profiles (i.e. no company listed).

Less useful is searching for a single company. This requires you to know which id is associated with the student, and probably means you can find this information by simply browsing the site yourself. But the world is your oyster, so
```ruby
scraper.get_company_name(12)
```
will return the single company name of the student matching the number you pass in.

##Sorting Methods
The gem provides two sort methods. 
1. To return a list of only unique company names, use the following method:
```
scraper.get_unique_company_names(80)
```
2. To return a list of companies sorted by number of former students listed as employed at those companies, use the count_companies method:
```
scraper.total_students_employed_per_company(80)
```
You can query the results of this method by passing in a company name as a hash key.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/jobs-former_students/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

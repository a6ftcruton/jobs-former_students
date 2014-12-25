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
To return a full, current list of company names, pass in a range limit to the `get_company_names` method:
```ruby
  scraper.get_company_names(80)
```

The above method will search 80 students and return an array of all companies found. As of the publishing date of Version 0.0.1 of this gem, student 65 is the last student with a valid company name. Pages after this represent either pages that do not exist or students who have incomplete profiles (i.e. no company listed).

Less useful is searching for a single company. This requires you to know which id is associated with the student, and probably means you can find this information by simply browsing the site yourself. But the world is your oyster, so
```ruby
scraper.get_company_name(12)
```
will return the single company name of the student matching the number you pass in.

##Sorting Methods
The gem provides three sort methods. 
1. To return an array of only unique company names, use the following method:

```ruby
scraper.get_unique_company_names(80)
```

2. To return a hash where showing the total number of students employed at each company, use the `total_students_employed_per_company` method:

```ruby
scraper.total_students_employed_per_company(80)
```

Example output:
```ruby
{"Welltok"=>1, "Zayo"=>4, "Active Junky"=>1, "Acumen Digital"=>4, "Kapost"=>1, "Verbalize.it"=>1, "Galvanize / gSchool"=>3, "TeamSnap"=>1, "Sports Shares"=>1, "Pivotal Labs"=>1, "Keen.io"=>1, "Blogmutt"=>1, "QuickLeft"=>2, "IBM BlueMix Garage"=>2, "HobbyDB"=>1, "Oildecks"=>1, "Lee Reedy"=>1, "Dfuzr"=>1, "Colorado Access"=>2, "CloudElements"=>1, "P2Binvestor"=>1, "gSchool"=>3, "Haught Codeworks"=>1, "Amex"=>2, "LegitScript"=>1, "RxRevu"=>1, "Apto"=>1, "Mondo Robot"=>1, "JayBird"=>1}
```

You can query the results of this method by passing in a company name as a hash key:
```ruby
results = scraper.total_students_employed_per_company(80)
results["Zayo"] # => 4 
```
To return a sorted list of these results, use the `sort_by_frequency` method:

`scraper.sort_by_frequency(80)`

Example output:
```ruby
[["Zayo", 4], ["Acumen Digital", 4], ["Galvanize / gSchool", 3], ["gSchool", 3], ["IBM BlueMix Garage", 2], ["Amex", 2], ["Colorado Access", 2], ["QuickLeft", 2], ["HobbyDB", 1], ["CloudElements", 1], ["Haught Codeworks", 1], ["Dfuzr", 1], ["Lee Reedy", 1], ["Oildecks", 1], ["P2Binvestor", 1], ["LegitScript", 1], ["RxRevu", 1], ["Blogmutt", 1], ["Keen.io", 1], ["Pivotal Labs", 1], ["Sports Shares", 1], ["TeamSnap", 1], ["Apto", 1], ["Verbalize.it", 1], ["Kapost", 1], ["Mondo Robot", 1], ["Active Junky", 1], ["JayBird", 1], ["Welltok", 1]]
```
## Contributing

1. Fork it ( https://github.com/[my-github-username]/jobs-former_students/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

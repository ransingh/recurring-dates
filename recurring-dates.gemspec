Gem::Specification.new do |spec|
  spec.name        = 'recurring-dates'
  spec.version     = '0.0.1'
  spec.date        = '2014-06-28'
  spec.summary     = "A simple gem to calculate repeat dates from a given date for daily, monthly, weekly, yearly basis."
  spec.description = "This gem calculates next dates from a given date based on a frequency of repetition. The repetition freqnecy can either be on daily, monthly, weekly or yearly basis."
  spec.authors     = ["Ranbir Singh"]
  spec.email       = 'ransingh57@yahoo.com'
  spec.files       = ["lib/recurring-dates.rb", "lib/recurring-dates/daily.rb", "lib/recurring-dates/monthly.rb", "lib/recurring-dates/weekly.rb", "lib/recurring-dates/yearly.rb", "lib/recurring-dates/period.rb", "lib/recurring-dates/util/integer.rb"]
  spec.homepage    = 'http://rubygems.org/gems/recurring-dates'
  spec.license       = 'MIT'


  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-nc"
  spec.add_development_dependency "timecop"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"  
end

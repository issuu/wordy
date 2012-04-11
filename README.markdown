[![Build Status](https://secure.travis-ci.org/bastien/wordy.png)](http://travis-ci.org/bastien/wordy)

Installation
------------

    gem install wordy
    
Usage
-----

```ruby
require 'rubygems'
require 'wordy'

# if you're using rails, put this in an initializer file
Wordy.configure do |c|
   c.api_key   = ENV['WORDY_API_KEY']
   c.username  = ENV['WORDY_USERNAME']
end

if Wordy::Account.balance > 0
  job = Wordy::Job.create(...)
  job.info
  job.pay
  puts "Your text will be ready at: #{job.delivery_date}"
end

```
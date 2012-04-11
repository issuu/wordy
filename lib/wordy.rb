require "net/http"
# require 'net/http/post/multipart'
# require 'digest/md5'
require 'uri'
require 'cgi'
require 'active_support'
# require 'active_support/hash_with_indifferent_access'

module Wordy
  WORDY_URL = URI.parse('https://staging.wordy.com/api/1.0/')
  
  class << self
    attr_accessor :api_key, :username
    
    # In your initializer:
    # Wordy.configure do |c|
    #   c.api_key   = ENV['WORDY_API_KEY']
    #   c.username  = ENV['WORDY_USERNAME']
    # end
    #
    def configure
      yield self
    end
  end
  
end

Dir[File.dirname(__FILE__) +"/wordy/*.rb"].each {|file| require file }
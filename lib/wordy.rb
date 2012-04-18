require "net/http"
require 'uri'
require 'cgi'
require 'active_support'

module Wordy
  WORDY_URL         = URI.parse('https://wordy.com/api/1.0/')
  WORDY_STAGING_URL = URI.parse('https://staging.wordy.com/api/1.0/')
  
  class << self
    attr_accessor :api_key, :username, :env
    
    # In your initializer:
    # Wordy.configure do |c|
    #   c.api_key   = ENV['WORDY_API_KEY']
    #   c.username  = ENV['WORDY_USERNAME']
    # end
    #
    def configure
      self.env = 'production'
      yield self
    end
    
    def wordy_url
      self.env == 'production' ? WORDY_URL : WORDY_STAGING_URL
    end
  end
  
end

Dir[File.dirname(__FILE__) +"/wordy/*.rb"].each {|file| require file }
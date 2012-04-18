module Wordy
  class Account
    class << self
      def balance
        response = Cli.http_get(Wordy.wordy_url+'account/', {})
        return nil if response.empty?
        response['balance'].to_s.match(/[^0-9]?([0-9]+\.{0,1}[0-9]+)/)[1].to_f
      end
      
      def languages
        Cli.http_get(Wordy.wordy_url+'languages/', {})
      end
    end
  end
end
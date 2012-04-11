module Wordy
  class Account
    class << self
      def balance
        response = Cli.http_get(Wordy::WORDY_URL+'account/', {})
        return nil if response.empty?
        response['balance']
      end
    end
  end
end
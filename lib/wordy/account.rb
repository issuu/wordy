module Wordy
  class Account
    class << self
      def balance
        response = Cli.http_get(Wordy::WORDY_URL+'account/', {})
      end
    end
  end
end
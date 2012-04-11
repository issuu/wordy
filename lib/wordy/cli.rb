module Wordy
  class Cli
    class << self
      def check_for_exceptions(json_data)
        if (!json_data.is_a? Array) && json_data['error'].present?
          raise WordyException, json_data['verbose']
        end
      end
      
      def decoded_response_body(response_body)
        if !response_body.empty?
          json_data = ActiveSupport::JSON.decode(response_body)
          check_for_exceptions(json_data)
          json_data
        else
          {}
        end
      end
      
      def http_get(url, params)
        path = "#{url.path}?".concat(params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.reverse.join('&')) unless params.nil?
        
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        
        request = Net::HTTP::Get.new(url.request_uri)        
        request.basic_auth Wordy.username, Wordy.api_key
        
        response = http.request(request)
        decoded_response_body(response.body)
      end
      
      def http_post(url, params)
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        
        request = Net::HTTP::Post.new(url.request_uri)
        request.set_form_data(params)
        request.basic_auth Wordy.username, Wordy.api_key
        
        response = http.request(request)
        decoded_response_body(response.body)
      end
    end
  end
  
  class WordyException < StandardError
  end
  
end
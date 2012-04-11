module Wordy
  class Job
    attr_reader :attributes
    
    def initialize(hash)
      @attributes = {}
      set_attributes(hash)
    end
    
    def set_attributes(hash)
      @attributes.update hash
      hash.each do |key, value|
        metaclass.send :attr_accessor, key
        instance_variable_set("@#{key}", value)
      end
    end
    
    def metaclass
      class << self
        self
      end
    end
    
    class << self
      
      # Parameters
      # ----------
      # language_id	
      # intrusive_editing (known in the front-end as content rewrite)	  true or false
      # brief	
      # fileToUpload	                                                  single file to be edited
      # content	                                                        raw text to be edited
      # json                                                            flat dictionary of content to be edited
      #
      # Response
      # --------
      #
      # id	      ID of the newly created job
      # url	      URL fragment of the newly created job
      #
      def create
        response = Cli.http_post(Wordy::WORDY_URL+'job/create/', {
          'json' => '{"My Title":"Hello world"}'
        })
        return new(response)
      end
      
      def all
        response = Cli.http_get(Wordy::WORDY_URL+"job/", {})
        response.map do |job_id|
          new({'id' => job_id})
        end
      end
    end
    
    def info
      response = Cli.http_get(Wordy::WORDY_URL+"job/#{self.id}/", {})
      set_attributes(response)
    end
    
    def conversation
      Cli.http_get(Wordy::WORDY_URL+"job/#{self.id}/conversation/", {})
    end
    
    def update_conversation(message)
      Cli.http_post(Wordy::WORDY_URL+"job/#{self.id}/conversation/", {'message' => message})
    end
    
    def pay
      Cli.http_post(Wordy::WORDY_URL+"job/#{self.id}/pay/", {})
    end
    
    def confirm
      Cli.http_post(Wordy::WORDY_URL+"job/#{self.id}/confirm/", {})
    end
    
    def reject
      Cli.http_post(Wordy::WORDY_URL+"job/#{self.id}/reject/", {})
    end
  end
end
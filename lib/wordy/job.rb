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
        if %w(delivery_date created).include? key
          value = DateTime.strptime(value.to_s,'%s')
        elsif key == "cost"
          value = value.to_s.match(/[^0-9]?([0-9]+\.{0,1}[0-9]+)/)[1].to_f
        end
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
      # fileToUpload	                                                  single file to be edited (not supported by this gem)
      # content	                                                        raw text to be edited
      # json                                                            flat dictionary of content to be edited '{"My Title":"My Content"}'
      #
      # Can only use one of those parameters: fileToUpload, content, json
      #
      # Response
      # --------
      #
      # id	      ID of the newly created job
      # url	      URL fragment of the newly created job
      #
      def create(language, content, title=nil, callback_url=nil, intrusive_editing=false, brief=nil)
        parameters = {:language_id => language, :intrusive_editing => intrusive_editing, :brief => brief, :callback_url => callback_url}
        if !title.nil? && !title.empty?
          parameters[:json] = ActiveSupport::JSON.encode({title => content})
        else
          parameters[:content] = content
        end
        parameters = parameters.delete_if{|key, value| value.nil? }
        response = Cli.http_post(Wordy.wordy_url+'job/create/', parameters)
        return new(response)
      end
      
      def all
        response = Cli.http_get(Wordy.wordy_url+"job/", {})
        response.map do |job_id|
          new({'id' => job_id})
        end
      end
      
      def find(id)
        job = new('id' => id)
        job.info
        job
      end
      
      def find_edited_document(id)
        job = new('id' => id)
        job.edited_document
        job
      end
    end
    
    def info
      response = Cli.http_get(Wordy.wordy_url+"job/#{self.id}/", {})
      set_attributes(response)
    end
    
    def edited_document
      response = Cli.http_get(Wordy.wordy_url+"job/#{self.id}/target/", {})
      edited_content = response.values[0]
      set_attributes({:edited_content => edited_content})
    end
    
    def conversation
      Cli.http_get(Wordy.wordy_url+"job/#{self.id}/conversation/", {})
    end
    
    def update_conversation(message)
      Cli.http_post(Wordy.wordy_url+"job/#{self.id}/conversation/", {'message' => message})
    end
    
    def pay!
      Cli.http_post(Wordy.wordy_url+"job/#{self.id}/pay/", {})
    end
    
    def confirm!
      Cli.http_post(Wordy.wordy_url+"job/#{self.id}/confirm/", {})
    end
    
    def reject!
      Cli.http_post(Wordy.wordy_url+"job/#{self.id}/reject/", {})
    end
  end
end
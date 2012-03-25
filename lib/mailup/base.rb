module MailUp
  class Base
    # Blank Slate
    instance_methods.each do |m|
      undef_method m unless m.to_s =~ /^__|object_id|method_missing|respond_to?|to_s|inspect|kind_of?|should|should_not|call/
    end
    
    # Dynamically find API methods
    def method_missing(api_method, *args) # :nodoc:
      call(api_method, *args)
    end
    
    # Check the WSDL for supported methods
    def respond_to?(api_method) # :nodoc:
      @client.wsdl.soap_actions.include?(api_method.to_sym)
    end
    
    # Make calls to the API
    def call(api_method, *args) # :nodoc:
      response = @client.request api_method.to_sym do |soap|
        soap.body = *args
        soap.body.merge!({:accessKey => @access_key})
      end
      data = XmlSimple.xml_in(response[("#{api_method}_response").to_sym], {'ForceArray' => false})
      raise APIError.new(data['errorCode'], data['errorDescription']) unless data['errorCode'] == 0
    end
  end
  
  class APIError < StandardError
    def initialize(code, message)
      super "<#{code}> #{message}"
    end
  end
end
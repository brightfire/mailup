module MailUp
  class Base
    # Blank Slate
    instance_methods.each do |m|
      undef_method m unless m.to_s =~ /^__|object_id|method_missing|respond_to?|public_methods|to_s|inspect|kind_of?|should|should_not|call/
    end
    
    # Dynamically find API methods
    def method_missing(api_method, *args) # :nodoc:
      @client.wsdl.soap_actions.include?(api_method.to_sym) ? call(api_method, *args) : super
    end
    
    # Check the WSDL for supported methods
    def respond_to?(api_method) # :nodoc:
      @client.wsdl.soap_actions.include?(api_method.to_sym)
    end
    
    # Display the supported methods
    def public_methods # :nodoc:
      @client.wsdl.soap_actions
    end
    
    # Make calls to the API
    def call(api_method, *args) # :nodoc:
      response = @client.request api_method.to_sym do |soap|
        body_hash = {}
        body_hash.merge!({:accessKey => @access_key}) if defined?(@access_key)
        body_hash.merge!(*args) unless args.empty?
        soap.body = body_hash
      end
      data = XmlSimple.xml_in(response["#{api_method}_response".to_sym]["#{api_method}_result".to_sym], {'ForceArray' => false})
      raise APIError.new(data['errorCode'], data['errorDescription']) unless data['errorCode'].to_i == 0
      data.delete_if {|x| x == 'errorCode' or x == 'errorDescription'}
      data
    end
  end
  
  class APIError < StandardError
    def initialize(code, message)
      super "<#{code}> #{message}"
    end
  end
end
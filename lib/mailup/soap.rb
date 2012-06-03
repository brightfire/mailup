module MailUp
  class Soap
    # Blank Slate
    instance_methods.each do |m|
      undef_method m unless m.to_s =~ /^__|object_id|method_missing|respond_to?|nil?|public_methods|to_s|inspect|kind_of?|should|should_not|call/
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
        # Add authentication header (if needed)
        soap.header = {"ins0:Authentication" => {"ins0:User" => @username, "ins0:Password" => @password}} if defined?(@username) and defined?(@password)
        body_hash = {}
        # Add access key (if needed)
        body_hash.merge!({:accessKey => @access_key}) if defined?(@access_key)
        body_hash.merge!(*args) unless args.empty?
        soap.body = body_hash
      end
      if defined?(@username) and defined?(@password)
        # (MailUp::Import)
        xml = Nokogiri::XML(response.body["#{api_method}_response".to_sym]["#{api_method}_result".to_sym])
        rc = xml.xpath('//ReturnCode').first.content.to_i
        raise SoapError.new(rc, MailUp::Import::ERRORS[rc]) if rc != 0
        response.body["#{api_method}_response".to_sym]["#{api_method}_result".to_sym]
      else
        # (MailUp::Manage, MailUp::Report, MailUp::Send)
        xml = Nokogiri::XML(response["#{api_method}_response".to_sym]["#{api_method}_result".to_sym])
        ec, em = xml.xpath('//errorCode').first.content.to_i, xml.xpath('//errorDescription').first.content
        raise SoapError.new(ec, em) if ec != 0
        response["#{api_method}_response".to_sym]["#{api_method}_result".to_sym]
      end
    end
  end
  
  class SoapError < StandardError
    attr_reader :data
    def initialize(data)
      @data = data
      super "The MailUp API responded with the following error code: #{data}"
    end
  end
end
module MailUp
  class Import
    # Blank Slate
    instance_methods.each do |m|
      undef_method m unless m.to_s =~ /^__|object_id|method_missing|respond_to?|public_methods|to_s|inspect|kind_of?|should|should_not|call/
    end
    
    # MailUp Import Service
    # https://mailup.atlassian.net/wiki/display/mailupapi/WebService+MailUpImport
    def initialize(username, password, console_url)
      @client = Savon::Client.new do
        wsdl.document = "http://#{console_url}/Services/WSMailupImport.asmx?WSDL"
      end
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
      
    end
  end
end
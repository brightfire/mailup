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
      @username, @password = username, password
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
        # TOOD: Combine into one Base class.
        # if defined? @username, @password
        # if defined? @accessKey
        soap.header = {
          "Authentication" => {
            "User" => @username,
            "Password" => @password
          }
        }
        body_hash = {}
        body_hash.merge!(*args) unless args.empty?
        soap.body = body_hash
      end
      data = XmlSimple.xml_in(response[:mailup_message][:mailup_body], {'ForceArray' => false})
      raise APIError.new(data['ReturnCode'], ERRORS[data['ReturnCode'].to_i]) if data['ReturnCode'].to_i < 0
      data.delete_if {|x| x == 'ReturnCode'}
      data
    end
    
    # Import service error descriptions
    ERRORS = {
      -2    => "ws name has not been specified",
      -4    => "user name has not been specified",
      -8    => "password has not been specified",
      -16   => "nl url has not been specified",
      -1000 => "unrecognized error",
      -1001 => "the account is not valid",
      -1002 => "the password is not valid",
      -1003 => "suspended account",
      -1004 => "inactive account",
      -1005 => "expired account",
      -1006 => "the web service is not enabled",
      -1007 => "the web service is not active",
      -1008 => "the web service is already active",
      -1009 => "web service activation error",
      -1010 => "IP registration error"
    }
  end
end
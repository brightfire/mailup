# TODO: Is there any SSL connections to the API?
# TODO: Can these all be GET or POST?
#       Is there any benefit to one or the other?
#       Should we allow people to decide if they use GET or POST?
# TODO: ws_activation does not seem to be working, but is returning
#       a code of 0 (success).
module MailUp
  class API
    # MailUp GET/POST API
    # https://mailup.atlassian.net/wiki/pages/viewpage.action?pageId=2752539
    def initialize(console_url)
      @console_url = console_url
    end
    
    # Blank Slate
    instance_methods.each do |m|
      undef_method m unless m.to_s =~ /^__|object_id|method_missing|respond_to?|nil?|public_methods|to_s|inspect|kind_of?|should|should_not|call/
    end
    
    # Dynamically find API methods
    def method_missing(api_method, *args) # :nodoc:
      raise ArgumentError.new('Please include method parameters.') unless args.size > 0
      params = ''
      args.each do |arg|
        params << arg.map {|k,v| "#{CGI::escape(k.to_s)}=#{CGI::escape(v.to_s)}"}.join("&")
        params << '&' unless arg == args.last
      end
      api_url = "http://#{@console_url}/frontend/#{camelize_api_method_name(api_method.to_s)}.aspx?#{params}"
      response = HTTPI.get(api_url)
      rc, rb = response.code, response.body.gsub( /\r\n/m,'').to_i
      # Raise an error if the method was not found.
      super if rc == 404
      # Raise an error if the request did not succeed.
      raise APIError.new(rc) if rc != 200
      # Raise an error if the IP is not authorized.
      raise APIError.new(rb) if rb == -1011
      # Raise an error if there was an error returned.
      raise APIError.new(rb) if rb == 1
      rb
    end
    
    # Check the API to see if a method is supported
    def respond_to?(api_method) # :nodoc:
      HTTPI.get("http://#{@console_url}/frontend/#{camelize_api_method_name(api_method.to_s)}.aspx").code == 200 ? true : false
    end
    
    # Display the supported methods
    def public_methods # :nodoc:
      [:ws_activation, :xml_subscribe, :xml_chk_subscriber, :xml_unsubscribe, :upd_subscriber]
    end
    
    # Import service error descriptions
    HTML_ERRORS = {
      403   => "Forbidden",
      404   => "Not found",
      422   => "Rejected",
      500   => "Internal server error"
    }
    
    private

    def camelize_api_method_name(str)
      str.to_s[0].chr.downcase + str.gsub(/(?:^|_)(.)/) { $1.upcase }[1..str.size]
    end
  end
  
  class APIError < StandardError
    attr_reader :data
    def initialize(data)
      @data = data
      super "The MailUp API responded with the following error code: #{data}"
    end
  end
end
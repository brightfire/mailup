module MailUp
  class Import < MailUp::Base
    
    # MailUp Import Service
    # https://mailup.atlassian.net/wiki/display/mailupapi/WebService+MailUpImport
    
    def initialize(username, password, console_url)
      @client = Savon::Client.new do
        wsdl.document = "http://#{console_url}/Services/WSMailupImport.asmx?WSDL"
      end
      @username, @password = username, password
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
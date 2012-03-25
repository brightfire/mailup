module MailUp
  class Import < MailUp::Base
    
    # MailUp Import Service
    # https://mailup.atlassian.net/wiki/display/mailupapi/WebService+MailUpImport
    
    def initialize(username, password)
      @client = Savon::Client.new do
        wsdl.document = 'https://wsvc.ss.mailup.it/MailupImport.asmx?WSDL'
      end
      @access_key = @client.request :login_from_id do |soap|
        soap.body = {:user => username, :pwd => password, :consoleId => username.gsub(/[a-z]/, '').to_i}
      end
    end
    
  end
end
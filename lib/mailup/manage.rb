module MailUp
  class Manage < MailUp::Base
    
    # MailUp Manage Service
    # https://mailup.atlassian.net/wiki/display/mailupapi/WebService+MailUpManage
    
    def initialize(username, password)
      @client = Savon::Client.new do
        wsdl.document = 'https://wsvc.ss.mailup.it/MailupImport.asmx?WSDL'
      end
      call(login_from_id, {:user => username, :pwd => password, :consoleId => username.gsub(/[a-z]/, '').to_i})
    end
    
  end
end
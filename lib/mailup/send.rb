module MailUp
  class Send < MailUp::Base
    
    # MailUp Send Service
    # https://mailup.atlassian.net/wiki/display/mailupapi/WebService+MailUpSend
    
    def initialize(username, password)
      @client = Savon::Client.new do
        wsdl.document = 'https://wsvc.ss.mailup.it/MailupSend.asmx?WSDL'
      end
      call(login_from_id, {:user => username, :pwd => password, :consoleId => username.gsub(/[a-z]/, '').to_i})
    end
    
  end
end
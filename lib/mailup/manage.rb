module MailUp
  class Manage < MailUp::Base
    
    # MailUp Manage Service
    # https://mailup.atlassian.net/wiki/display/mailupapi/WebService+MailUpManage
    
    def initialize(username, password)
      @client = Savon::Client.new do
        wsdl.document = 'https://wsvc.ss.mailup.it/MailupManage.asmx?WSDL'
      end
      @access_key = call('login_from_id', {:user => username, :pwd => password, :consoleId => username.gsub(/[a-z]/, '').to_i})['accessKey']
    end
    
  end
end
require 'spec_helper'

describe "Mailup" do
  describe "API" do
    it "should require a console_url" do
      expect {MailUp::API.new}.should raise_error(ArgumentError)
    end
  end

  describe "SOAP" do
    describe "Import class" do
      it "should require a username, password and console_url" do
        expect {MailUp::Import.new}.should raise_error(ArgumentError)
        expect {MailUp::Import.new('username')}.should raise_error(ArgumentError)
        expect {MailUp::Import.new('username', 'password')}.should raise_error(ArgumentError)
        expect {MailUp::Import.new('username', 'password', 'console_url')}.should_not raise_error(ArgumentError)
      end
    end

    describe "Manage, Report, Send classes" do
      it "should require a username and password" do
        expect {MailUp::Manage.new}.should raise_error(ArgumentError)
        expect {MailUp::Manage.new('username')}.should raise_error(ArgumentError)
      end
    end
  end
end

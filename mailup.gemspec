# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "mailup"
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brian Getting"]
  s.date = "2012-06-03"
  s.description = "Ruby gem for interacting with the MailUp email marketing service API."
  s.email = "brian@terra-firma-design.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    ".travis.yml",
    "Gemfile",
    "Guardfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/mailup.rb",
    "lib/mailup/api.rb",
    "lib/mailup/import.rb",
    "lib/mailup/manage.rb",
    "lib/mailup/report.rb",
    "lib/mailup/send.rb",
    "lib/mailup/soap.rb",
    "mailup.gemspec",
    "spec/mailup/mailup_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/terra-firma/mailup"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Ruby gem for interacting with the MailUp API."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<savon>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["> 1.0.0"])
      s.add_development_dependency(%q<fakeweb>, ["~> 1.3.0"])
      s.add_development_dependency(%q<guard-rspec>, ["~> 0.7.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.3"])
      s.add_development_dependency(%q<savon_spec>, ["~> 0.1.6"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.6.1"])
      s.add_development_dependency(%q<rspec>, ["~> 2.9.0"])
    else
      s.add_dependency(%q<savon>, [">= 0"])
      s.add_dependency(%q<bundler>, ["> 1.0.0"])
      s.add_dependency(%q<fakeweb>, ["~> 1.3.0"])
      s.add_dependency(%q<guard-rspec>, ["~> 0.7.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.3"])
      s.add_dependency(%q<savon_spec>, ["~> 0.1.6"])
      s.add_dependency(%q<simplecov>, ["~> 0.6.1"])
      s.add_dependency(%q<rspec>, ["~> 2.9.0"])
    end
  else
    s.add_dependency(%q<savon>, [">= 0"])
    s.add_dependency(%q<bundler>, ["> 1.0.0"])
    s.add_dependency(%q<fakeweb>, ["~> 1.3.0"])
    s.add_dependency(%q<guard-rspec>, ["~> 0.7.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.3"])
    s.add_dependency(%q<savon_spec>, ["~> 0.1.6"])
    s.add_dependency(%q<simplecov>, ["~> 0.6.1"])
    s.add_dependency(%q<rspec>, ["~> 2.9.0"])
  end
end


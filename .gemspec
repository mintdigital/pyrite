# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.version = "0.5.0"

  s.name = 'pyrite'
  s.summary = 'Easy peasy browser testing'
  s.description = 'A small, simple testing framework for use with selenium'
  s.authors = ["Adam Rogers","Dean Strelau"]
  s.email = 'adam@mintdigital.com'
  s.date = '2010-03-26'
  s.homepage = 'http://github.com/mintdigital/pyrite'
  s.files = [
    "lib/pyrite/assertions.rb",
    "lib/pyrite/dsl.rb",
    "lib/pyrite/helpers.rb",
    "lib/pyrite/pyrite_test.rb",
    "lib/pyrite/tasks.rb",
    "lib/pyrite/tasks/grid.rb",
    "lib/pyrite/tasks/pyrite.rb",
    "lib/pyrite/tasks/selenium.rb",
    "lib/pyrite.rb",
    "MIT-LICENSE",
    "tasks/pyrite.rake",
  ]
  s.require_paths = ["lib"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency 'selenium-client', '~> 1.2.18'
      s.add_runtime_dependency 'selenium_remote_control', '~> 1.0.3'
      s.add_runtime_dependency 'database_cleaner', '~> 0.5.0'
    else
      s.add_dependency 'selenium-client', '~> 1.2.18'
      s.add_dependency 'selenium_remote_control', '~> 1.0.3'
      s.add_dependency 'database_cleaner', '~> 0.5.0'
    end
  else
      s.add_dependency 'selenium-client', '~> 1.2.18'
      s.add_dependency 'selenium_remote_control', '~> 1.0.3'
      s.add_dependency 'database_cleaner', '~> 0.5.0'
  end

end

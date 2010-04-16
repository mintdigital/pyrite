# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.version = "0.5.2"

  s.name = 'pyrite'
  s.summary = 'Easy peasy browser testing'
  s.description = 'A small, simple testing framework for use with selenium'
  s.authors = ["Adam Rogers","Dean Strelau"]
  s.email = 'adam@mintdigital.com'
  s.homepage = 'http://mintdigital.github.com/pyrite'
  s.files = Dir["{lib,tasks}/**/*"] + %w[MIT-LICENSE README.rdoc]
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'selenium-client', '~> 1.2.18'
  s.add_runtime_dependency 'selenium_remote_control', '~> 1.0.3'
  s.add_runtime_dependency 'database_cleaner', '~> 0.5.0'
end

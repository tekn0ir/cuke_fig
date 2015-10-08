Gem::Specification.new do |s|
  s.name        = 'fig'
  s.version     = '0.0.1'
  s.date        = '2015-10-08'
  s.summary     = 'A YAML file config library for cucumber'
  s.description = 'Multilevel configuration for cucumber'
  s.authors     = ['Anders Åslund']
  s.email       = 'anders.aslund@teknoir.se'
  s.files       = Dir['lib/**/*']
  s.homepage    = 'http://www.teknoir.se'
  s.license     = 'MIT'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'cucumber'
  s.add_development_dependency 'rspec-expectations'
end

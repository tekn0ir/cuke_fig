require 'rubygems'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:cucumber) do |task|
  task.cucumber_opts = ['--format=progress', 'features']
end

task :travis do |t|
    Rake::Task[:cucumber].invoke
end

task :default => [:cucumber]
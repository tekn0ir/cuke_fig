require 'rubygems'
require 'bundler/setup'
require 'cucumber'
require 'rspec/expectations'
require 'cuke_fig'

Bundler.setup(:default, :development)

Before do
    @common = @env_configs = @override = nil
end

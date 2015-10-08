Given(/^I have a common config$/) do
  @common = Dir.glob(File.join(Dir.pwd, 'config_example/common/*.yml'))
end

Given(/^I have a multilevel config$/) do
  @common = Dir.glob(File.join(Dir.pwd, 'config_example/common/*.yml'))
  @env_configs = {
      env1: Dir.glob(File.join(Dir.pwd, 'config_example/env1/*.yml')),
      env2: Dir.glob(File.join(Dir.pwd, 'config_example/env2/*.yml')),
  }
end

Given(/^I have an overridden config$/) do
  @common = Dir.glob(File.join(Dir.pwd, 'config_example/common/*.yml'))
  @env_configs = {
      env1: Dir.glob(File.join(Dir.pwd, 'config_example/env1/*.yml')),
      env2: Dir.glob(File.join(Dir.pwd, 'config_example/env2/*.yml')),
  }
  @override = Dir.glob(File.join(Dir.pwd, 'config_example/override/*.yml'))
end

When(/^I setup the common config$/) do
  Fig::setup @common
end

When(/^I setup the (\w+\d+) config$/) do |env|
  Fig::setup @common, environment: env.to_sym, env_configs: @env_configs, override: @override
end

Then(/^I can use the (.+) config$/) do |keyword|
  expect(special_domain).to match( { top_level: a_string_starting_with(keyword),
                                    group: { first: a_string_starting_with(keyword), second: a_string_starting_with(keyword)},
                                    list: match_array([a_string_starting_with(keyword), a_string_starting_with(keyword), a_string_starting_with(keyword)]) })
  keyword = 'common'
  expect(common_domain).to match( { top_level: a_string_starting_with(keyword),
                                    group: { first: a_string_starting_with(keyword), second: a_string_starting_with(keyword)},
                                    list: match_array([a_string_starting_with(keyword), a_string_starting_with(keyword), a_string_starting_with(keyword)]) })
end





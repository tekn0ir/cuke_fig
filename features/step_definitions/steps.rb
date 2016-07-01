Given(/^I have a common config$/) do
  @common = 'config_example/common/*.yml'
end

Given(/^I have a multilevel config$/) do
  @common = 'config_example/common/*.yml'
  @env_configs = {
      env1: 'config_example/env1/*.yml',
      env2: 'config_example/env2/*.yml',
  }
end

Given(/^I have an overridden config$/) do
  @common = 'config_example/common/*.yml'
  @env_configs = {
      env1: 'config_example/env1/*.yml',
      env2: 'config_example/env2/*.yml',
  }
  @override = 'config_example/override/*.yml'
end

When(/^I setup the common config$/) do
  setup @common
end

When(/^I setup the (\w+\d+) config$/) do |env|
  setup @common, environment: env.to_sym, env_configs: @env_configs, override: @override
end

Then(/^I can use the (.+) config$/) do |keyword|
  expect(special_domain.top_level).to start_with(keyword)
  expect(special_domain.group.first).to start_with(keyword)
  expect(special_domain.group.second).to start_with(keyword)
  expect(special_domain.list).to match_array([a_string_starting_with(keyword), a_string_starting_with(keyword), a_string_starting_with(keyword)])

  keyword = 'common'
  expect(common_domain.top_level).to start_with(keyword)
  expect(common_domain.group.first).to start_with(keyword)
  expect(common_domain.group.second).to start_with(keyword)
  expect(common_domain.list).to match_array([a_string_starting_with(keyword), a_string_starting_with(keyword), a_string_starting_with(keyword)])
end





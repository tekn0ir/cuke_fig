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
  CukeFig::setup @common
end

When(/^I setup the (\w+\d+) config$/) do |env|
  CukeFig::setup @common, environment: env.to_sym, env_configs: @env_configs, override: @override
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





Feature: CukeFig
  As a frequent cucumber user
  I would like to be able to create multilevel configs
  To be able to reuse my tests for different environments

  Scenario: A simple config
    Given I have a common config
    When I setup the common config
    Then I can use the common config

  Scenario: A multilevl config (env1)
    Given I have a multilevel config
    When I setup the env1 config
    Then I can use the env1 config

  Scenario: A multilevl config (env2)
    Given I have a multilevel config
    When I setup the env2 config
    Then I can use the env2 config

  Scenario: An overridden config
    Given I have an overridden config
    When I setup the env2 config
    Then I can use the override config

# CukeFig

[![Build Status](https://secure.travis-ci.org/tekn0ir/cuke_fig.png)](http://travis-ci.org/tekn0ir/cuke_fig)
[![Dependency Status](https://gemnasium.com/tekn0ir/cuke_fig.png)](https://gemnasium.com/tekn0ir/cuke_fig)
[![Code Climate](https://codeclimate.com/github/tekn0ir/cuke_fig.png)](https://codeclimate.com/github/tekn0ir/cuke_fig)

CukeFig helps you set up multilevel configurations for your cucumber tests and makes
them easily accessible within the steps.

## Setup

CukeFig requires Ruby 2.0.0 or later. To install, add this line to your
`Gemfile` and run `bundle install`:

```ruby
gem 'cuke_fig'
```

In the cucumber feature support folder, add this line to your env.rb file:

```ruby
require 'cuke_fig'
```

In the cucumber feature support folder, create this file structure (as an example):

```bash
config
├── common
│   ├── common.yml
│   └── endpoints.yml
├── dev
│   └── endpoints.yml
├── qa
│   └── endpoints.yml
├── prod
│   └── endpoints.yml
└── override
    └── endpoints.yml
```

See more examples in the config_example folder. Initialize your configuration in the env.rb file like so (example):

```ruby
common = Dir.glob(File.join(Dir.pwd, 'features/support/config/common/*.yml'))
env_configs = {
  dev: Dir.glob(File.join(Dir.pwd, 'features/support/config/dev/*.yml')),
  qa: Dir.glob(File.join(Dir.pwd, 'features/support/config/qa/*.yml')),
  prod: Dir.glob(File.join(Dir.pwd, 'features/support/config/qa/*.yml'))
}
override = Dir.glob(File.join(Dir.pwd, 'features/support/config/override/*.yml'))

CukeFig::setup common, environment: ENV.fetch('ENV', :dev), env_configs: env_configs, override: override
```

Any number of env_configs can be passed in. Any number of YAML files can be created in each folder. 
Files with the same names will be merged in the following order:

```bash
config <= common <- {chosen env} <- override
           ----------precedence----------->
```

The endpoints.yml file in the dev folder can look like this:

```yaml
:myapi:
  :url: http://hostname
  :get_something_route: /route/to/something
```

You can now write your step definitions like so:

```ruby
Then(/^I can use the endpoints config like so$/) do
    conn = Faraday.new(:url => endpoints['myapi']['url'])
    
    response = conn.get endpoints['myapi']['get_something_route']
    response.body
end
```

## Contribution

### Bug Reports

If you are sure that it's a bug in CukeFig, open a new [issue] and try to
answer the following questions:

- What did you do?
- What did you expect to happen?
- What happened instead?

Please also post code to replicate the bug. Ideally a failing test would be
perfect, but even a simple script demonstrating the error would suffice.

### Pull Requests

- **Add tests!** Your patch won't be accepted if it doesn't have tests.

- **Document any change in behaviour**. Make sure the README and any other
  relevant documentation are kept up-to-date.

- **Create topic branches**. Don't ask us to pull from your master branch.

- **One pull request per feature**. If you want to do more than one thing, send
  multiple pull requests.

[issue]: https://github.com/tekn0ir/cuke_fig/issues

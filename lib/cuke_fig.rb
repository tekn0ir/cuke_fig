
module CukeFig
  class Config
    attr_reader :global_config, :methods

    def self.get
      @global_config ||= Config.new
    end

    def initialize
      @methods ||= []
    end

    def clear
      @global_config = Config.new
    end

    def load(conf_files)
      conf_files = [conf_files] unless conf_files.is_a? Array
      conf_files.each do |conf|
        attr_name = File.basename(conf, '.yml').gsub('-', '_')
        attr_value = YAML.load_file conf
        set attr_name, attr_value
      end
    end

    def set(attr_name, attr_value)
      var_name = ('@' + attr_name.to_s).to_sym
      if instance_variable_defined?(var_name) && attr_value.is_a?(Hash)
        # Get and merge. Keep merging if hash values are hashes
        merger = proc { |_key, v1, v2| v1.is_a?(Hash) && v2.is_a?(Hash) ? v1.merge(v2, &merger) : (v2.nil? ? v1 : v2) }
        instance_variable_get(var_name).merge! attr_value, &merger
      else
        # Create
        instance_variable_set(var_name, attr_value)
        singleton_class.class_eval { attr_reader attr_name }
        @methods << attr_name.to_s
      end
    end
  end

  def config
    Config.get
  end

  def expand_config_files(common, env_config: nil, override: nil)
    expanded = []
    expanded.concat common unless common.nil?
    expanded.concat env_config unless env_config.nil?
    expanded.concat override unless override.nil?
    expanded
  end

  def setup(common, environment: nil, env_configs: nil, override: nil)
    config.clear
    env_config = env_configs[environment] unless env_configs.nil? || environment.nil?
    config_files = expand_config_files common, env_config: env_config, override: override
    config.set(:env, environment)
    config.load(config_files)
    config.methods.each do |method|
      define_method method do |*args, &block|
        config.send method, *args, &block
      end
    end
  end

  extend(CukeFig)
end

World(CukeFig)

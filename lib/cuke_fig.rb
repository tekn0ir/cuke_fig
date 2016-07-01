require "yaml"
require "ostruct"

class Object
  def to_openstruct
    self
  end
end

class Array
  def to_openstruct
    map{ |el| el.to_openstruct }
  end
end

class Hash
  def to_openstruct
    mapped = {}
    each{ |key,value| mapped[key] = value.to_openstruct }
    OpenStruct.new(mapped)
  end
end

module YAML
  def self.load_openstruct(source)
    self.load(source).to_openstruct
  end
end

class CukeFig < OpenStruct
  def config
    self
  end

  def setup(common, environment: nil, env_configs: nil, override: nil)
    env_config = env_configs[environment] unless env_configs.nil? || environment.nil?
    config_files = expand_config_files common, env_config: env_config, override: override
    load(config_files)
  end

  def method_missing(mid, *args)
    @global_config.send(mid, *args)
  end

  private

  def expand_config_files(common, env_config: nil, override: nil)
    expanded = []
    expanded.concat Dir.glob(File.join(Dir.pwd, common)) unless common.nil?
    expanded.concat Dir.glob(File.join(Dir.pwd, env_config)) unless env_config.nil?
    expanded.concat Dir.glob(File.join(Dir.pwd, override)) unless override.nil?
    expanded
  end

  def load(conf_files)
    conf_files = [conf_files] unless conf_files.is_a? Array
    conf_hash = Hash.new
    conf_files.each do |conf|
      new_hash = { File.basename(conf, '.yml').gsub('-', '_').to_sym => YAML.load_file(conf) }
      conf_hash.merge!(new_hash)
    end
    @global_config = conf_hash.to_openstruct
  end
end

World{ CukeFig.new }

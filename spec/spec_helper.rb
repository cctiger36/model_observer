$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')
require 'rspec'
require 'rails'
require 'model_observer'

extend ModelObserver::Dependency

MODELS = File.join(File.dirname(__FILE__), "models")
$LOAD_PATH.unshift(MODELS)
SUPPORT = File.join(File.dirname(__FILE__), "support")
Dir[ File.join(SUPPORT, "*.rb") ].reject { |filename| filename =~ /_database.rb$/ }.sort.each { |f| require f }

if active_record?
  Dir[ File.join(MODELS, "*.rb") ].sort.each do |filename|
    name = File.basename(filename, ".rb")
    autoload name.camelize.to_sym, name
  end
  require File.join(SUPPORT, "sqlite_database.rb")

  RSpec.configure do |config|
    config.before(:all) do
      Support::SqliteDatabase.setup
      Support::SqliteDatabase.seed
    end

    config.after(:all) do
      Support::SqliteDatabase.teardown
    end
  end
end

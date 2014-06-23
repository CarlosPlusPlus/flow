# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Flow::Application.load_tasks
if defined?(RSpec)
  desc 'Run factory specs.'

  RSpec::Core::RakeTask.new(:factory_specs) do |t|
    t.pattern = './spec/models/factories_spec.rb'
  end

  task spec: :factory_specs
end
task(:default).clear
task :default => [:spec]

namespace :db do
  desc "Override ActiveRecord db:migrate task"
  task :migrate => :environment do
  end
end

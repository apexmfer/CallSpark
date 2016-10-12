

  require 'elasticsearch/rails/tasks/import'
namespace :db do

  desc ' '
  task init_elasticsearch: :environment do
    bundle exec rake environment elasticsearch:import:model CLASS='Company'
  end
end

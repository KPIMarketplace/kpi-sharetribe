require 'colorize'

# All production tasks & tasks which can't be on the Prod
namespace :db do
  desc 'Recreate the DB structure & populate it'
  task :recreate => :environment do
    puts 'DBs creation'.colorize(:yellow)
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:structure:load'].invoke

    puts 'Development Env'.colorize(:blue)
    Rake::Task['db:migrate'].invoke
    # Rake::Task['db:the_role:admin'].invoke
    Rake::Task['db:seed'].invoke

    puts 'Test Env'.colorize(:green)
    system('rake db:migrate RAILS_ENV=test')
    #Rake::Task['db:the_role:admin RAILS_ENV=test --trace'].invoke
    #system('rake db:seed RAILS_ENV=test --trace')

    # puts 'Local Production Env'.colorize(:grey)
    # system('rake db:migrate RAILS_ENV=production')
    # system('rake db:seed RAILS_ENV=production --trace')
  end
end
# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

every :day, :at => '2am' do # Use any day of the week or :weekend, :weekday
    rake "db:import_and_process_dump_data"
end


## need to use 'whenever --update-crontab'  to update the cron file 

# Learn more: http://github.com/javan/whenever

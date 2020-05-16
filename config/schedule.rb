# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

set :output, "/log/cron.log"
#
every 30.minutes do
 runner "Business.update_timings"
end

# Learn more: http://github.com/javan/whenever

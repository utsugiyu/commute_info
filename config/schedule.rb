# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
require File.expand_path(File.dirname(__FILE__) + "/environment")

set :environment, :production

set :output, "#{Rails.root}/log/cron.log"

every 1.minute do
  rake "info:get_info1"
  rake "info:get_info2"
end

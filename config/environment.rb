# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# Special date format to the model daily
Time::DATE_FORMATS[:daily] = "%b, %m %Y"

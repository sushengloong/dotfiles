require 'rubygems'
require 'awesome_print'
require 'interactive_editor'

# Clear the screen
def clear
  system 'clear'
  ENV['RAILS_ENV'] ? "Rails environment: #{ENV['RAILS_ENV']}" : "No rails environment - happy hacking!"
end

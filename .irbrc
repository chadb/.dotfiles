#require 'rubygems'
#require 'wirble'
#
#Wirble.init
#Wirble.colorize
#
#script_console_running = ENV.include?('RAILS_ENV') && IRB.conf[:LOAD_MODULES] && IRB.conf[:LOAD_MODULES].include?('console_with_helpers')
#rails_running = ENV.include?('RAILS_ENV') && !(IRB.conf[:LOAD_MODULES] && IRB.conf[:LOAD_MODULES].include?('console_with_helpers'))
#irb_standalone_running = !script_console_running && !rails_running
#
#if script_console_running
#  require 'logger'
#  Object.const_set(:RAILS_DEFAULT_LOGGER, Logger.new(STDOUT))
#end

#!/usr/bin/env ruby
require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

# ActiveRecord::Base.logger.level = 1 if defined? ActiveRecord::Base

def y(obj)
  puts obj.to_yaml
end

class Object
  def mate(method_name)
    file, line = method(method_name).source_location
    `mate '#{file}' -l #{line}`
  end
end

# Break out of the Bundler jail
# from https://github.com/ConradIrwin/pry-debundle/blob/master/lib/pry-debundle.rb
#if defined? Bundler
#  Gem.post_reset_hooks.reject! { |hook| hook.source_location.first =~ %r{/bundler/} }
#  Gem::Specification.reset
#  load 'rubygems/custom_require.rb'
#end

#if defined? Rails
#  begin
#    require 'hirb'
#    Hirb.enable
#  rescue LoadError
#  end
#end
if defined? Rails
  begin
    require 'wirb'
    Wirb.start
  rescue LoadError
  end
end

if defined?(Rails)
  class Object

    include Rails::ConsoleMethods

    def vim(method_name)
      file, line = method(method_name).source_location
      fork do
        exec("vim +#{line} '#{file}'")
      end
      Process.wait
      reload!
    end

    alias :v :vim
  end
end


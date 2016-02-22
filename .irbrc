#!/usr/bin/env ruby
require 'irb/completion'
require 'irb/ext/save-history'
require 'awesome_print'
AwesomePrint.irb!

IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

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


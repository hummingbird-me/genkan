require 'simplecov'
require 'simplecov-lcov'

module SimpleCov
  module Formatter
    class MergedFormatter
      def format(result)
        SimpleCov::Formatter::HTMLFormatter.new.format(result)
        SimpleCov::Formatter::LcovFormatter.new.format(result)
      end
    end
  end
end

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/config/'
  add_filter '/db/'
  add_filter '/vendor/'

  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'
  add_group 'Mailers', 'app/mailers'
  add_group 'Services', 'app/services'
  add_group 'Libs', 'lib/'

  track_files '{app,lib}/**/*.rb'
end
SimpleCov.formatter = SimpleCov::Formatter::MergedFormatter

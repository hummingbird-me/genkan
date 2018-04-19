require 'active_support/inflector'

guard :rspec, cmd: 'bin/rspec -f doc' do
  # spec/*_helper.rb -> all specs
  watch(%r{spec/.*_helper.rb})                        { 'spec' }
  # spec/support/*.rb -> all specs
  watch(%r{spec/support/.*.rb})                       { 'spec' }
  # app/**/(application|base)_*.rb--> all relevant spec groups
  watch('app/controllers/application_controller.rb')  { 'spec/controllers' }
  watch('app/models/application_record.rb')           { 'spec/models' }
  # spec/**/* --> itself
  watch(%r{^spec/(.+)_spec\.rb$})                     { |m| "spec/#{m[1]}_spec.rb" }
  # app/**/* -> corresponding spec
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  # lib/**/* -> corresponding spec
  watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  # spec/factories/*.rb --> factories_spec & related model spec
  watch(%r{^spec/factories/(.+).rb})                  { |m| ["spec/factories_spec.rb", "spec/models/#{m[1].singularize}_spec.rb"] }
end

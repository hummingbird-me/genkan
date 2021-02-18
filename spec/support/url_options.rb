# Set up URL Options
RSpec.configure do |c|
  c.before(:example) { Thread.current[:url_options] = { host: 'example.com' } }
end

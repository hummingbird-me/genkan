module WithThreadVariable
  extend ActiveSupport::Concern

  module_function

  def with_thread_variable(vars)
    vars.each { |key, value| Thread.current[key] = value }

    begin
      yield
    ensure
      vars.keys.each { |key| Thread.current[key] = nil }
    end
  end
end

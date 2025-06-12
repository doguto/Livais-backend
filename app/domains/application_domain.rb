require "logger"

class ApplicationDomain
  def initialize
    @logger_stdout = Logger.new($stdout)
  end

  def execute
    raise "implement this method in subclass"
  end
end

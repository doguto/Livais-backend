class ApplicationService
  def initialize
    @logger_stdout = Logger.new($stdout)
  end
end

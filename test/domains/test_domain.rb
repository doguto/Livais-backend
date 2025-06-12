require "logger"
require_relative "../../app/services/application_service"
parent_dir = File.expand_path("../../", __dir__)
puts parent_dir
Dir.glob(File.join("#{parent_dir}/app/services/", "*.rb")).each do |file|
  next if file == "application_service.rb"

  require file
end

class TestDomain
  def initialize
    @logger_stdout = Logger.new($stdout)
  end
end

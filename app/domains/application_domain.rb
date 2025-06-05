require "logger"

class ApplicationDomain
  def initialize
    @logger_stdout = Logger.new($stdout)
  end

  def execute
    raise "implement this method in subclass"
  end

  private

  def following_ids_for
    user = Current.current_user
    return Set.new unless user

    user.following.pluck(:id).to_set
  end
end

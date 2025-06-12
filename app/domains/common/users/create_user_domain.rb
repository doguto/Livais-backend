module Common::Users
  class CreateUserDomain < ApplicationDomain
    def initialize(params:)
      super()
      @params = params
    end

    def execute
      user = User.new(@params)
      if user.save
        user.create_profile unless user.profile
        Result.new(true, user, nil)
      else
        Result.new(false, nil, user.errors.full_messages)
      end
    end

    Result = Struct.new(:succcess?, :user, :errors)
  end
end

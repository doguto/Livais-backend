module Page::AuthPage
  class LogoutDomain < ApplicationDomain
    def initialize(cookies)
      super()
      @cookies = cookies
    end

    def execute
      @cookies.delete(:jwt)
    end
  end
end

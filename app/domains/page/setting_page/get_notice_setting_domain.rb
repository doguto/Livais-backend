module Page::SettingPage
  class GetNoticeSettingDomain < ApplicationDomain
    def execute
      user = Current.current_user
      user.notice_setting.as_json
    end
  end
end

module Page::SettingPage
  class EditNoticeSettingDomain < ApplicationDomain
    def execute(request_obj)
      Current.current_user.notice_setting.update!(
        like_enable: request_obj.like_enable,
        repost_enable: request_obj.repost_enable,
        quote_enable: request_obj.quote_enable,
        reply_enable: request_obj.reply_enable,
        follow_enable: request_obj.follow_enable
      )

      true
    end
  end
end

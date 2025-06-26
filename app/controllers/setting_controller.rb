class SettingController < ApplicationController
  def notice
    notice_setting = Page::SettingPage::GetNoticeSettingDomain.new.execute
    render json: notice_setting, status: :ok
  end

  def edit_notice
    request_obj = NoticeSettingRo.new(params)
    is_success = Page::SettingPage::EditNoticeSettingDomain.new.execute(request_obj)
    render json: { success: is_success }, status: is_success ? :ok : :unprocessable_entity
  end
end

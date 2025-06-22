class NoticeController < ApplicationController
  def index
    dtos = Page::NoticePage::ShowNoticeDomain.new.execute
    response = dtos.nil? ? {} : dtos.map(&:get)
    render json: response, status: :ok
  end

  def hide
    is_success = Page::NoticePage::HideNoticeDomain.new.execute(params[:notice_id])
    render json: { success: is_success }, status: is_success ? :ok : :unprocessable_entity
  end

  def edit
    request_obj = NoticeSettingRo.new(params)
    is_success = Page::NoticePage::EditNoticeSettingDomain.new.execute(request_obj)
    render json: { success: is_success }, status: is_success ? :ok : :unprocessable_entity
  end
end

class NoticeController < ApplicationController
  def index
    dtos = Page::NoticePage::ShowNoticeDomain.new.execute
    render json: dtos.map(&:get), status: :ok
  end

  def hide
    is_success = Page::NoticePage::HideNoticeDomain.new.execute(params[:notice_id])
    render json: { success: is_success }, status: is_success ? :ok : :unprocessable_entity
  end

  def edit
    is_success = Page::NoticePage::EditNoticeSettingDomain.new.execute(params)
    render json: { success: is_success }, status: is_success ? :ok : :unprocessable_entity
  end
end

class NoticeController < ApplicationController
  def show
    dtos = Page::NoticePage::ShowNoticeDomain.new.execute
    render json: dtos.map(&:get), status: :ok
  end
end

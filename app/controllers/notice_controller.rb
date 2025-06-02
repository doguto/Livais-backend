class NoticeController < ApplicationController
  def show
    dtos = ShowNoticeDomain.new.execute
    render json: dtos.map(&:get), status: :ok
  end
end

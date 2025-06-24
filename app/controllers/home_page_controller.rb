class HomePageController < ApplicationController
  def show_follow_timeline
    dtos = Page::HomePage::FollowTimelineDomain.new.execute
    render json: dtos, status: :ok
  end
end

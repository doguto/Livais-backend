class HomePageController < ApplicationController
  def show
    request_object = HomeTimelineRo.new(params)

    dtos = if request_object.tab.default?
             Page::HomePage::TimelineDomain.new.execute
           elsif request_object.tab.follow?
             Page::HomePage::FollowTimelineDomain.new.execute
           end
    render json: dtos, status: :ok
  end
end

class ShowNoticeDomain < ApplicationDomain
  def initialize
    super
    @contain_post_type = ["Repost", "Like", "Post"]
  end

  def execute
    current_user = Current.user
    notices = Notice.where(user_id: current_user.id).includes(:notifiable).order(created_at: :desc)
    dtos = []
    notices.map do |notice|
      if notice.notifiable_type == "Follow"
        dtos << NoticeDto.new(notice, user_id: notice.notifiable.user_id)
      elsif @contain_post_type.include?(notice.notifiable_type)
        dtos << NoticeDto.new(notice, user_id: notice.notifiable.user_id, post_id: notice.notifiable.id)
      end
    end
    dtos
  end
end

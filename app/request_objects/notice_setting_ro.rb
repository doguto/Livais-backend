class NoticeSettingRo
  attr_accessor :like_enable, :repost_enable, :quote_enable, :reply_enable, :follow_enable

  def initialize(params)
    @like_enable = params[:like_enable]
    @repost_enable = params[:repost_enable]
    @quote_enable = params[:quote_enable]
    @reply_enable = params[:reply_enable]
    @follow_enable = params[:follow_enable]
  end
end

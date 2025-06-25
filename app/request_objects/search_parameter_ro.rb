class SearchParameterRo
  FILTER_LIVE = "live".freeze
  FILTER_USERS = "users".freeze

  VALID_FILTERS = [FILTER_LIVE, FILTER_USERS].freeze
  DEFAULT_FILTER = FILTER_LIVE

  attr_reader :q, :f

  def initialize(params)
    @q = params[:q]
    filter_param = params[:f]
    @f = if VALID_FILTERS.include?(filter_param)
           filter_param
         else
           DEFAULT_FILTER
         end
  end
end

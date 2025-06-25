class SearchParameterRo
  extend Enumerize

  attr_reader :q

  enumerize :f, in: [:live, :users], default: :live
  def initialize(params)
    @q = params[:q]
    self.f = params[:f]
  end
end

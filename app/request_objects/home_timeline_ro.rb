class HomeTimelineRo
  extend Enumerize

  enumerize :tab, in: [:default, :follow], predicates: true, default: :default

  def initialize(params)
    @tab = params.fetch(:tab, :default)
  end
end

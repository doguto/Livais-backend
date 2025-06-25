class SearchController < ApplicationController
  def index
    query = search_params.q
    filters = search_params.f

    return render json: [] if query.blank?

    results = case filters
              when "live"
                Page::SearchPage::SearchPostsDomain.new.execute(query)
              when "users"
                Page::SearchPage::SearchUsersDomain.new.execute(query)
              end

    render json: results.map(&:get).as_json
  end

  private

  def search_params
    SearchParameterRo.new(params.permit(:q, :f))
  end
end

class SearchController < ApplicationController
  def index
    search_ro = SearchParameterRo.new(params)
    query = search_ro.q

    return render json: [] if query.blank?

    results = if search_ro.f.live?
                Page::SearchPage::SearchPostsDomain.new.execute(query)
              elsif search_ro.f.users?
                Page::SearchPage::SearchUsersDomain.new.execute(query)
              end

    render json: results.map(&:get).as_json
  end
end

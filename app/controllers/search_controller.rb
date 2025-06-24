class SearchController < ApplicationController
  def index
    query = params[:q]
    filters = params[:f] || "live"

    return render json: [] if query.blank?

    results = case filters
              when "live"
                Page::SearchPage::SearchPostsDomain.new(query).execute
              when "users"
                Page::SearchPage::SearchUsersDomain.new(query).execute
              else
                []
              end

    render json: results.map(&:get).as_json
  end

  private

  def search_params
    params.permit(:q, :f)
  end
end

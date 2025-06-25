module Page::SearchPage
  class SearchUsersDomain < ApplicationDomain
    def execute(query)
      return User.none if query.blank?

      users = User.includes(:profile)
        .left_outer_joins(:profile)
        .where(
          "LOWER(users.name) LIKE LOWER(?) OR LOWER(profiles.self_introduction) LIKE LOWER(?)",
          "%#{query}%",
          "%#{query}%"
        )

      UserDto.from_collection(users)
    end
  end
end

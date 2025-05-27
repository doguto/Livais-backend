# Don't Add attributes here easily.
# Add attributes only if we use the attributes in almost all API requests.

class Current < ActiveSupport::CurrentAttributes
  attribute :current_user, :user
end

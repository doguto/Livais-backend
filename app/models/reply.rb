class Reply < ApplicationRecord
  belongs_to :parent_post, class_name: "Post", inverse_of: :replies
  belongs_to :child_post, class_name: "Post", inverse_of: :replies
end

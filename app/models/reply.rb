class Reply < ApplicationRecord
  belongs_to :parent_post, class_name: "Post", inverse_of: :child_replies
  belongs_to :child_post, class_name: "Post", inverse_of: :parent_reply
end

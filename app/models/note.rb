class Note < ApplicationRecord
  belongs_to :creator, class_name: "User"

  has_rich_text :body
end

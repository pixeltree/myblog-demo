class Post < ApplicationRecord
  has_rich_text :body

  validates_presence_of :title, :body
end

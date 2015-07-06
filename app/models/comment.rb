class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :improvement
  validates :content, length: {maximum:2000}
  validates_presence_of :content
end

class Improvement < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates :content, length: {maximum:2000}
  validates_presence_of :title
  validates_presence_of :content
end

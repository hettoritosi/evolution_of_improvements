class Improvement < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  belongs_to :status
  belongs_to :responsible
  validates :content, length: {maximum:2000}
  validates_presence_of :title
  validates_presence_of :content
end

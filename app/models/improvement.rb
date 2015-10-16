class Improvement < ActiveRecord::Base

  belongs_to :user
  has_many :comments
  belongs_to :status
  belongs_to :responsible, class_name: User

  delegate :name, to: :user

  validates :content, length: {maximum:2000}
  validates_presence_of :title

  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      all
    end
  end


end

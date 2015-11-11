class Improvement < ActiveRecord::Base
  require 'csv'

  belongs_to :user
  has_many :comments
  belongs_to :status
  belongs_to :responsible, class_name: User

  delegate :name, to: :user

  validates :content, length: {maximum:3000}
  validates_presence_of :title

  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      all
    end
  end

  # def self.import_improvements()
  #   CSV.foreach("public/Limbo.csv") do |row|
  #     record = Improvement.new(
  #         :title => row[0],
  #         :content   => row[1],
  #         :category  => row[3],
  #         :status_id => '3',
  #         :user_id => '9',
  #         :responsible_id =>'9'
  #       )
  #       record.save!
  #   end
  #
  # end


  def self.to_csv(options = {})
    CSV.generate do |csv|
      csv << column_names
      all.each do |improvement|
        csv << improvement.attributes.values_at(*column_names)
      end
    end
  end

end

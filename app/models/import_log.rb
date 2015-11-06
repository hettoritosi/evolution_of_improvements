class ImportLog < ActiveRecord::Base
  has_attached_file :file
  validates_attachment :file, presence: true,
                       :content_type => { content_type: 'text/csv' }
  has_one :user
end

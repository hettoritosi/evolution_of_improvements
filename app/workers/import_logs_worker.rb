class ImportLogsWorker

  include Sidekiq::Worker

  require 'csv'


  def perform(id, csv_file, user)
    @import_log = ImportLog.find(id)
    @import_log.status_import = "In Progress"
    @import_log.save

    current_line = 1
    total = csv_file.count
    csv_file.each do |row|

      record = Improvement.new(
          :title => (row[0].blank? ? 'Title missing' : row[0]),
          :content   => row[1],
          :category  => row[3],
          :status_id => '2',         #id 2 = In Progress
          :user_id => user,              #id 6 = Murilo
          :responsible_id =>'1'
      )
      record.save!
      total_percent = (100*current_line)/total
      current_line += 1
      if @import_log.total_percent != total_percent
        @import_log.total_percent = total_percent
        @import_log.save
      end
    end
    @import_log.status_import = "Finished"
    @import_log.save
    end


end
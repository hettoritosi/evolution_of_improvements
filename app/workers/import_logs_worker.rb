class ImportLogsWorker

  include Sidekiq::Worker

  def perform(id)
    @import_log = ImportLog.find(id)
    @import_log.status_import = 'In Progress'
    @import_log.save
    current_line = 1
    csv_file = CSV.read(@import_log.file.path)
    total = csv_file.count
    csv_file.each do |row|
      record = Improvement.new(
          :title => (row[0].blank? ? 'Title missing' : row[0]),
          :content   => row[1],
          :category  => row[3],
          :status_id => '3',            #id 2 = In Progress
          :user_id => '9',              #id 6 = Murilo
          :responsible_id =>'9'
      )
      record.save!
      total_percent = (100*current_line)/total
      current_line += 1
      if @import_log.total_percent != total_percent
        @import_log.total_percent = total_percent
        @import_log.save
      end
    end
    @import_log.status_import = 'Finished'
    @import_log.save
    end


end
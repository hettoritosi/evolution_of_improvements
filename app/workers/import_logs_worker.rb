class ImportLogsWorker

  include Sidekiq::Worker

  require 'csv'


  def perform(id, user)
    @import_log = ImportLog.find(id)
    @import_log.status_import = "In Progress"
    @import_log.save

    current_line = 2
    total = CSV.read(@import_log.file.path).count

    CSV.foreach(@import_log.file.path, :headers => true, :col_sep => ',') do |row|
        Improvement.create( {
          :title => row['Macro'] || 'Título Faltando',
          :content   => row['Frente'],
          :category  => row['Projeto'],
          :status_id => '2',         #id 2 = In Progress
          :user_id => user,
          :responsible_id => user
                            }
      )
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
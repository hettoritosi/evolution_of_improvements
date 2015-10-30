class ImportLogsController < ApplicationController

  def create
    @import_log = ImportLog.new(importlog_params)
    @import_log.status_import = "In Progress"
    @import_log.save
    current_line = 1
    if @import_log.file.blank?
    else
    csv_file = CSV.read(@import_log.file.path)
    total = csv_file.count
    csv_file.each do |row|
      record = Improvement.new(
          :title => (row[0].blank? ? 'Title missing' : row[0]),
          :content   => row[1],
          :category  => row[3],
          :status_id => '2',            #id 2 = In Progress
          :user_id => '1',              #id 6 = Murilo
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
    end
    respond_to do |format|
      if @import_log.save
        format.html { redirect_to controller: 'import_logs', action: 'new', id: @import_log.id}
      else
        @import_type = [['Tasks', "Improvement"]]
        format.html { render :new }
      end
    end
  end

  def new
     @import_type = [['Tasks', "Improvement"]]
     @import_log = ImportLog.new
     if !params[:id].blank?
       @import_log_update = ImportLog.find(params[:id])
     end

  end


  def ajax_import_log
    import_log = ImportLog.find(params[:id])
    render :json => [import_log.total_percent, import_log.status_import]
  end


private

  def importlog_params
    params.require(:import_log).permit(:type_import, :file)
  end


end

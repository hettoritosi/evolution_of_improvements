class ImportLogsController < ApplicationController

  def create
    @import_type = [['Tasks', "Improvement"]]
    @import_log = ImportLog.new(importlog_params)
    @import_log.status_import = 'Initialized'
    respond_to do |format|
      if @import_log.save
        ImportLogsWorker.perform_async(@import_log.id)
        format.html { redirect_to controller: 'import_logs', action: 'new', id: @import_log.id}
    else
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

class ImportLogsController < ApplicationController



  def create
    @import_log = ImportLog.new(importlog_params)
    @import_log.status_import = "Initialized"
    @import_log.save
    if @import_log.file.blank?
    else
    user = current_user.id
    ImportLogsWorker.perform_async(@import_log.id,user)
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
     if !params[:id].blank?   #Se ele não estiver em branco
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

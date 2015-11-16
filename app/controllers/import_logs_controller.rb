class ImportLogsController < ApplicationController

  before_action :only_logged

  require 'csv'

  def verify_user_id_by_sub_name(sub_name)
    user = current_user.id
    sub_name = sub_name.split('/').first.to_s
    user_id = User.where(:sub_name => sub_name.upcase.gsub(/\s+/, "")).first
    if user_id
      user_id.id
    else
      user
    end
  end


  def create
    @import_log = ImportLog.new(importlog_params)
    @import_log.status_import = "In Progress"
    @import_log.save
    if @import_log.file.blank?
    else
      user = current_user.id
      current_line = 2
      total = CSV.read(@import_log.file.path).count


      CSV.foreach(@import_log.file.path, :headers => true, :col_sep => ',') do |row|
        id = verify_user_id_by_sub_name row['Responsável']
        Improvement.create( {
                                :title => row['Macro'] || 'Título Faltando',
                                :content   => row['Frente'],
                                :category  => row['Projeto'],
                                :status_id => '2',         #id 2 = In Progress
                                :user_id => user,
                                :responsible_id  => id
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
    respond_to do |format|
      if @import_log.save
        format.html { redirect_to controller: 'import_logs', action: 'new', id: @import_log.id}
      else
        @import_type = [['Tarefas', "Improvement"]]
        format.html { render :new }
      end
    end
  end

  def new
     @import_type = [['Tarefas', "Improvement"]]
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

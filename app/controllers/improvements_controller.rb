class ImprovementsController < ApplicationController
  before_action :set_improvement, only: [:show, :edit, :update, :destroy]
  before_action :set_responsibles, only: [:new, :edit]
  before_action :set_statuses, only: [:new, :edit]
  before_action :only_logged, except:[:create_mobile, :update_mobile, :index, :show, :index_mobile ]

  helper_method :sort_column, :sort_direction



  # GET /improvements
  # GET /improvements.json
  def index
    @improvement = Improvement.all
    respond_to do |format|
        format.html {@improvement}
        format.json { render json: @improvement, include: [:user , :status, :responsible]}
        format.csv { render text: @improvement.to_csv }
        format.xls  { send_data @improvement.to_xls(:columns => [:title,:content,:category,:responsible_id,:created_at,:updated_at], :headers => ['Título','Conteúdo','Categoria','Responsável ID','Criado em ','Atualizado em'])}
    end


    all_status = Status.get_all_status
    @improvements = Improvement.search(params[:search]).where("status_id = 1 OR status_id = 2", current_user.id)
                               .where("status_id in (?)", params[:status] || all_status)
                               .order(sort_column + " " + sort_direction)
                               .paginate(:per_page => 10, :page => params[:page])
    @user = current_user
  end


  # GET /improvements/1
  # GET /improvements/1.json
def show
    @improvement = Improvement.find(params[:id])
    respond_to do |format|
    format.html {@improvement}
    format.json { render json: @improvement, include: [:user,:status,:responsible]}
  end
end

  # GET /improvements/new
  def new
    @improvement = Improvement.new
    @status = Status.all
  end

  # GET /improvements/1/edit
  def edit
    @status = Status.all
  end

  # POST /improvements
  # POST /improvements.json
  def create
    @improvement = Improvement.new (improvement_params)
   @improvement.user_id = current_user.id
   @status = Status.all
   @responsible = User.all

    respond_to do |format|
      if @improvement.save
        format.html { redirect_to @improvement, notice: 'Tarefa foi criada com sucesso.' }
        format.json { render :show, status: :created, location: @improvement }
      else
        format.html { render :new }
        format.json { render json: @improvement.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_mobile
    @improvement = Improvement.new
    @improvement.status_id = 2  #Status In Progress
    @improvement.responsible_id = params[:responsible_id].to_i
    @improvement.user_id = params[:user_id].to_i
    @improvement.title = params[:title]
    @improvement.category = params[:category]
    @improvement.content = params[:content]
    @improvement.save
  end

  # PATCH/PUT /improvements/1
  # PATCH/PUT /improvements/1.json
  def update
    all_status = Status.get_all_status
    @improvements = Improvement.search(params[:search]).where("(responsible_id = ?) AND status_id != 3", current_user.id)
                        .where("status_id in (?)", params[:status] || all_status)
                        .order(sort_column + " " + sort_direction)
                        .paginate(:per_page => 10, :page => params[:page])

    @improvements_graveyard = Improvement.search(params[:search]).where("status_id = 3", current_user.id)
                        .where("status_id in (?)", params[:status] || all_status)
                        .order(sort_column + " " + sort_direction)
                        .paginate(:per_page => 10, :page => params[:page])

    @improvements_index = Improvement.search(params[:search]).where("status_id = 1 OR status_id = 2", current_user.id)
                        .where("status_id in (?)", params[:status] || all_status)
                        .order(sort_column + " " + sort_direction)
                        .paginate(:per_page => 10, :page => params[:page])


    respond_to do |format|
      if @improvement.update(improvement_params)
        format.html { redirect_to improvements_path, notice: 'Tarefa foi atualizada com sucesso.' }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @improvement.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_mobile
      @improvement = Improvement.find(params[:id])
      @improvement.status_id = params[:status_id].to_i
      @improvement.save
  end


  # DELETE /improvements/1
  # DELETE /improvements/1.json
  def destroy
    @improvement.destroy
    respond_to do |format|
      format.html { redirect_to improvements_path, notice: 'Tarefa foi apagada com sucesso.' }
      format.json { head :no_content }
    end
  end

  def index_mobile
    @improvement = Improvement.all
    respond_to do |format|
      format.html {@improvement}
      format.json { render json: @improvement, include: [:user , :status, :responsible]}
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_improvement
    @improvement = Improvement.find(params[:id])
  end

  def set_responsibles
    @responsible = User.where(permission: true).all
  end

  def set_statuses
    @status = Status.all
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def improvement_params
    params.require(:improvement).permit(:title, :category, :content, :user_id, :status_id, :responsible_id)
  end



  def sort_column
    Improvement.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end




end
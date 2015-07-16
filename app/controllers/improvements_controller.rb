class ImprovementsController < ApplicationController
  before_action :set_improvement, only: [:show, :edit, :update, :destroy]
  before_action :set_responsibles, only: [:new, :edit]
  before_action :set_statuses, only: [:new, :edit]

  # GET /improvements
  # GET /improvements.json
  def index
    @improvements = Improvement.order(params[:sort])
  end

  # GET /improvements/1
  # GET /improvements/1.json
  def show
  end

  # GET /improvements/new
  def new
    @improvement = Improvement.new
    @status = Status.all
  end

  # GET /improvements/1/edit
  def edit
  end

  # POST /improvements
  # POST /improvements.json
  def create
    @improvement = Improvement.new(improvement_params)
    @improvement.user_id = current_user.id

    respond_to do |format|
      if @improvement.save
        format.html { redirect_to @improvement, notice: 'Improvement was successfully created.' }
        format.json { render :show, status: :created, location: @improvement }
      else
        format.html { render :new }
        format.json { render json: @improvement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /improvements/1
  # PATCH/PUT /improvements/1.json
  def update
    respond_to do |format|
      if @improvement.update(improvement_params)
        format.html { redirect_to @improvement, notice: 'Improvement was successfully updated.' }
        format.json { render :show, status: :ok, location: @improvement }
      else
        format.html { render :edit }
        format.json { render json: @improvement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /improvements/1
  # DELETE /improvements/1.json
  def destroy
    @improvement.destroy
    respond_to do |format|
      format.html { redirect_to current_user, notice: 'Improvement was successfully destroyed.' }
      format.json { head :no_content }
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
end
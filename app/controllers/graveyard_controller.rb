class GraveyardController < ApplicationController
  include ApplicationHelper
  helper_method :sort_column, :sort_direction



  def index
    @user = User.find(current_user)
    all_status = Status.get_all_status
    @improvements = Improvement.search(params[:search]).where("status_id = 3", current_user.id)
                        .where("status_id in (?)", params[:status] || all_status)
                        .order(sort_column + " " + sort_direction)
                        .paginate(:per_page => 10, :page => params[:page])
  end


  def sort_column
    Improvement.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

end

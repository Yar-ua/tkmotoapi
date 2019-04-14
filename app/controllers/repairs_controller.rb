class RepairsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_bike
  before_action :set_repair, only: [:update, :destroy]

  def index
    @repairs = Repair.where(bike_id: @bike.id).order(created_at: :desc)
    send_response(@repairs, 200)
  end

  def create
    if current_user_is_bike_owner
      @repair = @bike.repairs.build(repair_params)
      if @repair.save
        send_response(@repair, 200, [success: 'Repair stata successfully created'])
      else
        send_response(nil, 422, nil, @repair.errors)
      end
    else
      error_not_bike_owner
    end
  end

  def update
    if current_user_is_bike_owner
      if @repair.update(repair_params)
        send_response(@repair, 200, [success: 'Repair successfully updated'])
      else
        send_response(nil, 403, nil, @repair.errors)
      end
    else
      error_not_bike_owner
    end  
  end

  def destroy
    if current_user_is_bike_owner
      if @repair.destroy
        send_response(nil, 200, [success: 'Repair was deleted'])
      else
        send_response(nil, 422, nil, @repair.errors)
      end
    else
      error_not_bike_owner
    end
  end


  private

  def repair_params
    params.require(:repair).permit(:description, :detail, :price_detail)
  end

  def set_repair
    @repair = Repair.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      send_response(nil, 404, nil, 'Repair\'s data not found')
    return @repair
  end

end

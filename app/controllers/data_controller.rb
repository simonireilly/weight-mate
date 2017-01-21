class DataController < ApplicationController
  def create
    @data = current_user.data.new(data_params)
    @data.save
    redirect_to action: 'index'
  end

  private
  def data_params
    params.require(:datum).permit(:excercise, :sets, :reps, :weight)
  end

end

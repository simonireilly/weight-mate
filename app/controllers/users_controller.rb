class UsersController < ApplicationController
  def home
    @data = Datum.new

    if current_user && current_user.data
      @workoutData = current_user.data.all
    end
  end
end

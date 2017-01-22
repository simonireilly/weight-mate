class UsersController < ApplicationController
  def home
    @data = Datum.new
    @workoutData = []
    if current_user && current_user.data
      current_user.data.each do |datum|
        @workoutData.push([datum.created_at.to_date,datum.sets])
      end
    end
  end
end

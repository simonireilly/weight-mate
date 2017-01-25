class UsersController < ApplicationController
  def home

    @data = Datum.new
    @workoutSets = []
    @workoutReps = []
    @workoutWeight = []
    @workoutIntensity = []

    if current_user && current_user.data
      @modelData= current_user.data.all
      @modelData.each do |datum|
        @date = datum.created_at
        @intensity = datum.weight*datum.reps*datum.sets

        @workoutSets.push([@date,datum.sets])
        @workoutReps.push([@date,datum.reps])
        @workoutWeight.push([@date,datum.weight])
        @workoutIntensity.push([@date, @intensity])
      end

      @intensityData = [
          {name: "intensity", data: @workoutIntensity}
      ]
    end
  end

  def intensity

    @returnedData = 0
    @dates = []
    @intensityArray = []

    if current_user && current_user.data.count >= 1

      (current_user.data.first.created_at.to_date..current_user.data.last.created_at.to_date).each do |date|
        @returnedData = 0
        current_user.data.where(created_at: date.midnight..date.end_of_day).all.each do |datum|
          @returnedData += datum.weight*datum.reps*datum.sets
        end
        @intensityArray.push([date, @returnedData])
      end
      @intensityData = [
          {name: "intensity", data: @intensityArray}
      ]
    end
  end

  def records
    if current_user && current_user.data
      @collection = current_user.data.pluck(:excercise).uniq

        if @collection.include? params[:excercise_filter]
          @modelData = current_user.data.excercise(params[:excercise_filter])
          @workoutSets = []
          @workoutReps = []
          @workoutWeight = []
          @workoutIntensity = []

          @modelData.each do |datum|
            @date = datum.created_at
            @intensity = datum.weight*datum.reps*datum.sets

            @workoutSets.push([@date,datum.sets])
            @workoutReps.push([@date,datum.reps])
            @workoutWeight.push([@date,datum.weight])
          end
          @graphData = [
              {name: "Sets", data: @workoutSets},
              {name: "Reps", data: @workoutReps},
              {name: "Weight", data: @workoutWeight},
          ]

        else
          @modelData= current_user.data.all
        end
    end
  end
end

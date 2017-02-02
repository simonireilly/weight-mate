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

    @returned_data = 0
    @dates = []
    @intensity_array = []

    if current_user && current_user.data.count >= 1

      (current_user.data.first.created_at.to_date..current_user.data.last.created_at.to_date).each do |date|
        @returned_data = 0
        current_user.data.where(created_at: date.midnight..date.end_of_day).all.each do |datum|
          @returned_data += datum.weight*datum.reps*datum.sets
        end
        @intensity_array.push([date, @returned_data])
      end
      @intensity_data = [
          {name: "intensity", data: @intensity_array}
      ]
      @total_attendance = 0
      @all_intensity = 0
      @intensity_array.each {|date, intensity|  @total_attendance += 1 if intensity > 0; @all_intensity += intensity if intensity > 0 }
      @average_attendance = (7 * @total_attendance / @intensity_array.size).round
      @all_intensity = @all_intensity/@total_attendance
      @check = covariance([2.0,4.0,6.0,8.0],[1.0,2.0,1.0,4.0])
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
            @workoutIntensity.push([@date,@intensity])
          end
          @graphData = [
              {name: "Sets", data: @workoutSets},
              {name: "Reps", data: @workoutReps},
              {name: "Weight", data: @workoutWeight},
              {name: "Intensity", data: @workoutIntensity}
          ]
         else
          @modelData= current_user.data.all
        end
    end
  end

  def maximum

    @collection = current_user.data.pluck(:excercise).uniq
    @array = @collection.to_ary
    @records = []
    @array.each do |excercise|
      @record = current_user.data.where(excercise: excercise).order(weight: :desc).first
      @records.push(@record)
    end
    @records = @records.sort_by &:excercise
  end

  def gains

  end


end

def covariance(xs,ys)
  x_column = []
  y_column = []
  xs.each_with_index { |xv,index | x_column[index] = xv - mean(xs) }
  ys.each_with_index { |yv,index | y_column[index] = yv - mean(ys) }
  yx_product = x_column.zip(y_column).map{|x,y| x*y}
  (yx_product.sum / (xs.size))

end
def variance(xs,ys)

# variance is S^2 = sum((xi-x_bar)^2) / n-1
# You should be able to code this no bother!
end
def mean(values)
  "Method failed to run - values passed not an array" unless values.kind_of?(Array)
  values.sum/values.length
end
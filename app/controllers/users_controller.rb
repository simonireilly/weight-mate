class UsersController < ApplicationController
  def home
    @data = Datum.new
  end
end

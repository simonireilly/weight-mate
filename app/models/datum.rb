class Datum < ApplicationRecord
  belongs_to :user
  @allowed_types = ['Pull-ups']
  validates :excercise, presence: true, :inclusion=> { :in => @allowed_types }
  validates :sets, presence: true
  validates :reps, presence: true
  validates :weight, presence: true
end

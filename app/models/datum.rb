class Datum < ApplicationRecord
  scope :excercise, -> (excercise) { where excercise: excercise }
  belongs_to :user
  validates :excercise, presence: true
  validates :sets, presence: true
  validates :reps, presence: true
  validates :weight, presence: true

end

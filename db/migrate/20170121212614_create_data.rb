class CreateData < ActiveRecord::Migration[5.0]
  def change
    create_table :data do |t|
      t.references :user, foreign_key: true
      t.string :excercise
      t.decimal :sets
      t.decimal :reps
      t.decimal :weight
      t.string :srw
      t.string :decimal

      t.timestamps
    end
  end
end

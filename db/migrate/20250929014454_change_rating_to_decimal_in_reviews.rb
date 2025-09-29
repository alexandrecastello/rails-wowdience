class ChangeRatingToDecimalInReviews < ActiveRecord::Migration[7.0]
  def change
    change_column :reviews, :rating, :decimal, precision: 3, scale: 1
  end
end

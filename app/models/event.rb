class Event < ApplicationRecord
  belongs_to :event_type
  belongs_to :location
  has_many :event_artists
  has_many :artists, through: :event_artists
  has_many :reviews
  has_many :users, through: :reviews

  validates :name, presence: true
  validates :start_date, presence: true

  def average_rating
    return 0 if reviews.empty?
    reviews.average(:rating).round(1)
  end

  def total_reviews
    reviews.count
  end
end

class Event < ApplicationRecord
  belongs_to :event_type
  belongs_to :location
  has_many :event_artists
  has_many :artists, through: :event_artists
  has_namy :reviews
  has_many :users, through: :reviews, alias: :reviewers
end

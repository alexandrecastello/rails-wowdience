class Review < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user_id, uniqueness: { scope: :event_id, message: "Você já avaliou este evento" }
  validates :rating, presence: true, inclusion: { in: 0..5.0, message: "A nota deve estar entre 0.5 e 5.0" }
end

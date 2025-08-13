class Game < ApplicationRecord
  STATUSES = %w[Backlog Playing Completed Dropped].freeze

  validates :title, presence: true
  validates :platform, presence: true
  validates :status, inclusion: { in: STATUSES }, allow_nil: true
  validates :rating, numericality: { allow_nil: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :cover_url, format: { with: /\Ahttps?:\/\/[\S]+\z/, message: "must be a valid URL" }, allow_blank: true
end

class Task < ApplicationRecord
  PRIORITIES = %w[low medium high].freeze
  IMAGE_TYPES = %w[image/jpeg image/png image/webp image/gif].freeze
  MAX_IMAGE_SIZE = 5.megabytes

  has_one_attached :image

  validates :title, presence: true, length: { maximum: 120 }
  validates :notes, length: { maximum: 500 }
  validates :priority, inclusion: { in: PRIORITIES }
  validate :acceptable_image

  scope :active, -> { where(completed: false) }
  scope :completed, -> { where(completed: true) }
  scope :due_today, -> { where(due_date: Date.current) }
  scope :matching, lambda { |query|
    term = "%#{sanitize_sql_like(query)}%"
    where("title ILIKE :term OR notes ILIKE :term", term: term)
  }

  def overdue?
    !completed? && due_date.present? && due_date < Date.current
  end

  private

  def acceptable_image
    return unless image.attached?

    errors.add(:image, "chỉ hỗ trợ JPG, PNG, WebP hoặc GIF") unless image.content_type.in?(IMAGE_TYPES)
    errors.add(:image, "không được lớn hơn 5 MB") if image.byte_size > MAX_IMAGE_SIZE
  end
end

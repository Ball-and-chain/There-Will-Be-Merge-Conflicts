class Reading < ActiveRecord::Base
  validates :lesson_id, presence: true

  belongs_to :courses

  belongs_to :lesson

  default_scope { order('order_number') }

  scope :pre, -> { where("before_lesson = ?", true) }
  scope :post, -> { where("before_lesson != ?", true) }

  def clone
    dup
  end
end

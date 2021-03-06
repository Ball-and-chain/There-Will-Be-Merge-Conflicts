class Reading < ActiveRecord::Base
  validates :lesson_id, presence: true
  validates :caption, presence: true

  belongs_to :lesson
  belongs_to :course

  default_scope { order('order_number') }

  scope :pre, -> { where("before_lesson = ?", true) }
  scope :post, -> { where("before_lesson != ?", true) }

  def clone
    dup
  end
end

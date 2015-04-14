# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime
#  updated_at :datetime
#

class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED), message: "I DON'T EVEN THAT STATUS" }, presence: true
  validate :no_overlapping_approved_requests

  after_initialize :set_pending

  belongs_to :cat

  def overlapping_requests
    CatRentalRequest.where(["NOT ( end_date < :start_date OR :end_date < start_date)", { start_date: self.start_date, end_date: self.end_date }]).where("(:id IS NULL) OR (id != :id)", id: self.id)
  end

  def overlapping_approved_requests
    overlapping_requests.where("status = 'APPROVED'")
  end

  def no_overlapping_approved_requests
    (errors[:base] << "Cat is not available on these dates.") unless overlapping_approved_requests.empty?
  end

  def set_pending
    @status ||= "PENDING"
  end
end

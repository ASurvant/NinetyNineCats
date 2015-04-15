# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#

class Cat < ActiveRecord::Base
  validates :birth_date, presence: true
  validates :color, inclusion: { in: %w(White Black Red Blue Cream Brown Cinnamon Fawn), message: "cats don't even that color" }, presence: true
  validates :name, presence: true
  validates :sex, presence: { in: %w(M F), message: "cats don't even that gender" }, presence: true
  validates :user_id, presence: true

  has_many :cat_rental_requests, dependent: :destroy

  has_one :owner, class_name: 'User', foreign_key: :user_id, primary_key: :id

  def age
    seconds = Time.now - Time.parse(birth_date.to_s)
    (seconds / 31536000).floor
  end

end

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
#

class Cat < ActiveRecord::Base
  validates :birth_date, presence: true
  validates :color, inclusion: { in: %w(white black red blue cream brown cinnamon fawn), message: "cats don't even that color" }, presence: true
  validates :name, presence: true
  validates :sex, presence: { in: %w(M F), message: "cats don't even that gender" }, presence: true

  def age
    seconds = Time.now - @birth_date
    seconds / 31536000
  end
end

class Schedule < ApplicationRecord
  belongs_to :room
  belongs_to :course
  has_and_belongs_to_many :students
end

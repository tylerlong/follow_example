class Followship < ActiveRecord::Base
  belongs_to :user
  belongs_to :followable, polymorphic: true
  attr_accessible :followable

  validates :user, presence: true
  validates :followable, presence: true
end

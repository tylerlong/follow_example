class Followship < ActiveRecord::Base
  belongs_to :user
  belongs_to :followable, polymorphic: true
end

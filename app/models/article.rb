class Article < ActiveRecord::Base
  belongs_to :user
  has_many :followships, as: :followable
  attr_accessible :name
end

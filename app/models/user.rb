class User < ActiveRecord::Base
  has_many :followships
  has_many :articles
  has_many :events
  attr_accessible :name

  def hello
  end
end

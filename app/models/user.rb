require "followable"

class User < ActiveRecord::Base
  has_many :articles
  has_many :events
  attr_accessible :name

  include Followable
end

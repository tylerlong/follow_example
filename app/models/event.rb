require "followable"

class Event < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name

  include Followable
end

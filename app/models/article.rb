require "followable"

class Article < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name

  include Followable
end

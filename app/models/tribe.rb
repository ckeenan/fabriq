class Tribe < ActiveRecord::Base
	attr_accessible :name, :desc
	has_many :users
end

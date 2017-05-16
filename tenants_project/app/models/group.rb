class Group < ApplicationRecord
	has_many :roles, as: :resource
end

class Role < ApplicationRecord
	has_many :roles_users
	has_many :users, through: :roles_users
    belongs_to :resource, polymorphic: true
end

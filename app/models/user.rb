class User < ActiveRecord::Base
	has_secure_password

	has_many :paintings, dependent: :destroy
end

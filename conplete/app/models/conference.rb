class Conference < ApplicationRecord
	has_many :talks, dependent: :destroy
end

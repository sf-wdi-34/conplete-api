class Talk < ApplicationRecord
  belongs_to :conference, optional: true
end

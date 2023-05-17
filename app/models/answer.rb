class Answer < ApplicationRecord
  has_one :question

  self.primary_key = 'id' 

  
end

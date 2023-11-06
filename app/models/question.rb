class Question < ApplicationRecord
    validates :question, length: {minimum: 1, maximum: 1000}, allow_blank: false
    validates :answer, length: {minimum: 1, maximum: 1000}, allow_blank: false
end

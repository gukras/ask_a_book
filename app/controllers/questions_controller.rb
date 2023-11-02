class QuestionsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def ask
        answer_text = ["hello world", "hello gaston","Hi our you"].sample
        id_number = rand(100)  

        render json: { answer: answer_text, id: id_number }
    end
end
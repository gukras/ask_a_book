class QuestionsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:ask]  # Equivalent to Django csrf_exempt. It may not be the best solution, but is copying the original code.

    def ask
        question_asked = params[:question] || ""
    
        question_asked += '?' unless question_asked.end_with?('?')
    
        #A better solution can be use to store the question as a vector, and find a non exact answer
        previous_question = Question.find_by(question: question_asked)
    
        if previous_question
            previous_question.ask_count += 1
            previous_question.save
            render json: { question: previous_question.question, answer: previous_question.answer, id: previous_question.id }
        else
            answer, context = QueryResponder.answer_query_with_context(question_asked)

            question = Question.create(question: question_asked, answer: answer, context: context)
            puts question.errors.full_messages
            render json: { question: question.question, answer: answer, id: question.id }
        end
    end

    def question 
        @question = Question.find(params[:id])
    end
end
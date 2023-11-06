class DbController < ApplicationController
    before_action :authenticate_user!

    def index
        @questions = Question.select("question, answer, ask_count").order(ask_count: :desc)
    end
end

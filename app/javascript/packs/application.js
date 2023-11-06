import React from 'react';
import { createRoot } from 'react-dom/client';
import Home from '../components/Home';
import QuestionsList from '../components/QuestionsList';
//window.QuestionsList = QuestionsList;

document.addEventListener('DOMContentLoaded', () => {
    const homeElement = document.getElementById('home_page');
    if (homeElement) {
        const question = homeElement.getAttribute('data-question');
        const answer = homeElement.getAttribute('data-answer');
        const root = createRoot(homeElement);
        root.render(<Home initialQuestion={question} initialAnswer={answer}/>);
    }

    const dbElement = document.getElementById('db_page');
    if (dbElement) {
        const questions = dbElement.getAttribute('data-questions');
        const root = createRoot(dbElement);
        root.render(<QuestionsList questions={questions} />);
    }
    
});




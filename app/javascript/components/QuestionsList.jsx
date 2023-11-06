import React, { useState, useEffect } from 'react';

const QuestionsList = (props) => {
  const [questions, setQuestions] = useState(JSON.parse(props['questions']) || {});

  return (
    <div>
      <h2>{questions.length}/500 questions answered</h2>
      <ul className="queue">
        {questions.map((question, index) => (
          <li key={index}>
            <strong>{question.question}</strong>
            <p>{question.answer}</p>
            <p><small>Asked {question.ask_count} times</small></p>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default QuestionsList;

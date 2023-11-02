import React, { useState, useEffect, useRef } from 'react'; 
const Home = () => {

    const formRef = useRef(null);
    const [question, setQuestion] = useState('What is a minimalist entrepreneur?');
    const [answer, setAnswer] = useState("");  
    const [isLoading, setIsLoading] = useState(false);
    const [displayedAnswer, setDisplayedAnswer] = useState("");  

    useEffect(() => {
        if (answer !== "") {
            setIsLoading(true);

            let typingInterval = setInterval(() => {
                if (displayedAnswer.length < answer.length) {
                    setDisplayedAnswer(answer.slice(0, displayedAnswer.length + 1));
                } else {
                    clearInterval(typingInterval);
                    setIsLoading(false);
                }
            }, Math.floor(Math.random() * (70 - 30 + 1) + 30));

            return () => clearInterval(typingInterval);
        }
    }, [answer, displayedAnswer]);


    const handleSubmit = async (e) => {
        if (e && e.preventDefault) {
            e.preventDefault();
        }

        if (!question.trim()) {  
            alert("Please ask a question!");
            return;
        }
    
        setIsLoading(true);

        const formData = new FormData();
        formData.append('question', question);
    
        const response = await fetch('/ask', {
          method: 'POST',
          body: formData,
        });
    
        const responseData = await response.json();
    
        setAnswer(responseData.answer);
        window.newQuestionId = responseData.id;
        history.pushState({}, null, "/question/" + window.newQuestionId);
        setIsLoading(false); 
        
    };

    const handleTextChange = (e) => {
        setQuestion(e.target.value);
    };

    const handleLuckyClick = (e) => {
        e.preventDefault();
        const options = ["What is a minimalist entrepreneur?", "What is your definition of community?", "How do I decide what kind of business I should start?"];

        const randomChoice = options[Math.floor(Math.random() * options.length)];
        setQuestion(randomChoice);

        handleSubmit();
    };

    const handleAskAnotherClick = (e) => {
        setDisplayedAnswer("");       
        setAnswer("");        
    }

    return (  
        <div>
            <div className="header">
                <div className="logo">
                    <a href="https://www.amazon.com/Minimalist-Entrepreneur-Great-Founders-More/dp/0593192397">
                        <img src={require('../../assets/images/bookCover.png')} alt="Book Cover" />    
                    </a>
                    <h1>Ask Sahil Lavingia Book</h1>
                </div>
            </div>
         
            <div className="main">
                <p className="credits">
                    This is an experiment in using AI to make Sahil Lavingia book's content more accessible. Ask a question and AI'll answer it in real-time:
                </p>
                <form onSubmit={handleSubmit} ref={formRef}> 
                    <textarea 
                        name="question"
                        value={question}
                        onChange={handleTextChange}
                        placeholder="Type your question here..."
                        rows="2"
                        cols="50"
                    />
                    <div className="buttons" style={answer !== "" ? { display: "none" } : {}}>                     
                        <button disabled={isLoading} type="submit" id="ask-button">{isLoading ? 'Asking...' : 'Ask question'}</button>
                        <button disabled={isLoading} id="lucky-button" onClick={handleLuckyClick} style={{background: '#eee', borderColor: '#eee', color: '#444'}}>I'm feeling lucky</button>          
                    </div>
                </form>
                {answer ? 
                    <p id="answer-container" className="">
                        <strong>Answer:&nbsp;</strong> 
                        <span id="answer">{displayedAnswer}</span> 
                        <button disabled={isLoading} id="ask-another-button" onClick={handleAskAnotherClick} style={{display: 'block'}}>
                            {isLoading ? 'Asking...' : 'Ask another question'}
                        </button>
                    </p>
                : null}

            </div>

            <footer>
                <p className="credits">Project by Gaston Krasny • <a href="https://github.com/slavingia/askmybook">Forked from Sahil Lavingia GitHub</a></p>
            </footer>
        </div>
    );
}

export default Home;

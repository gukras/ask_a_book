Object.defineProperty(exports, '__esModule', {
    value: true
});

var _this = this;

var _slicedToArray = (function () { function sliceIterator(arr, i) { var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i['return']) _i['return'](); } finally { if (_d) throw _e; } } return _arr; } return function (arr, i) { if (Array.isArray(arr)) { return arr; } else if (Symbol.iterator in Object(arr)) { return sliceIterator(arr, i); } else { throw new TypeError('Invalid attempt to destructure non-iterable instance'); } }; })();

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var _react = require('react');

var _react2 = _interopRequireDefault(_react);

var Home = function (props) {

    var initialQuestion = props['initialQuestion'];
    var initialAnswer = props['initialAnswer'];
    var formRef = (0, _react.useRef)(null);

    var _useState = (0, _react.useState)(initialQuestion || 'What is The Minimalist Entrepreneur about?');

    var _useState2 = _slicedToArray(_useState, 2);

    var question = _useState2[0];
    var setQuestion = _useState2[1];

    var _useState3 = (0, _react.useState)(initialAnswer || "");

    var _useState32 = _slicedToArray(_useState3, 2);

    var answer = _useState32[0];
    var setAnswer = _useState32[1];

    var _useState4 = (0, _react.useState)(false);

    var _useState42 = _slicedToArray(_useState4, 2);

    var isLoading = _useState42[0];
    var setIsLoading = _useState42[1];

    var _useState5 = (0, _react.useState)(initialAnswer || "");

    var _useState52 = _slicedToArray(_useState5, 2);

    var displayedAnswer = _useState52[0];
    var setDisplayedAnswer = _useState52[1];

    (0, _react.useEffect)(function () {
        if (answer !== "") {
            var _ret = (function () {
                setIsLoading(true);

                var typingInterval = setInterval(function () {
                    if (displayedAnswer.length < answer.length) {
                        setDisplayedAnswer(answer.slice(0, displayedAnswer.length + 1));
                    } else {
                        clearInterval(typingInterval);
                        setIsLoading(false);
                    }
                }, Math.floor(Math.random() * (70 - 30 + 1) + 30));

                return {
                    v: function () {
                        return clearInterval(typingInterval);
                    }
                };
            })();

            if (typeof _ret === 'object') return _ret.v;
        }
    }, [answer, displayedAnswer]);

    var handleSubmit = function callee$1$0(e) {
        return regeneratorRuntime.async(function callee$1$0$(context$2$0) {
            while (1) switch (context$2$0.prev = context$2$0.next) {
                case 0:
                    if (e && e.preventDefault) {
                        e.preventDefault();
                    }
                    askQuestion(question);

                case 2:
                case 'end':
                    return context$2$0.stop();
            }
        }, null, _this);
    };

    var handleTextChange = function (e) {
        setQuestion(e.target.value);
    };

    var handleLuckyClick = function (e) {
        e.preventDefault();
        var options = ["What is a minimalist entrepreneur?", "What is your definition of community?", "How do I decide what kind of business I should start?"];

        var randomChoice = options[Math.floor(Math.random() * options.length)];
        setQuestion(randomChoice);

        askQuestion(randomChoice);
    };

    var handleAskAnotherClick = function (e) {
        setDisplayedAnswer("");
        setAnswer("");
    };

    var askQuestion = function callee$1$0(question) {
        var formData, response, responseData;
        return regeneratorRuntime.async(function callee$1$0$(context$2$0) {
            while (1) switch (context$2$0.prev = context$2$0.next) {
                case 0:
                    if (question.trim()) {
                        context$2$0.next = 3;
                        break;
                    }

                    alert("Please ask a question!");
                    return context$2$0.abrupt('return');

                case 3:

                    setIsLoading(true);

                    formData = new FormData();

                    formData.append('question', question);

                    context$2$0.next = 8;
                    return regeneratorRuntime.awrap(fetch('/ask', {
                        method: 'POST',
                        body: formData
                    }));

                case 8:
                    response = context$2$0.sent;
                    context$2$0.next = 11;
                    return regeneratorRuntime.awrap(response.json());

                case 11:
                    responseData = context$2$0.sent;

                    setAnswer(responseData.answer);
                    window.newQuestionId = responseData.id;
                    history.pushState({}, null, "/question/" + window.newQuestionId);
                    setIsLoading(false);

                case 16:
                case 'end':
                    return context$2$0.stop();
            }
        }, null, _this);
    };

    return _react2['default'].createElement(
        'div',
        null,
        _react2['default'].createElement(
            'div',
            { className: 'header' },
            _react2['default'].createElement(
                'div',
                { className: 'logo' },
                _react2['default'].createElement(
                    'a',
                    { href: 'https://www.amazon.com/Minimalist-Entrepreneur-Great-Founders-More/dp/0593192397' },
                    _react2['default'].createElement('img', { src: require('../../assets/images/bookCover.png'), alt: 'Book Cover' })
                ),
                _react2['default'].createElement(
                    'h1',
                    null,
                    'Ask Sahil Lavingia Book'
                )
            )
        ),
        _react2['default'].createElement(
            'div',
            { className: 'main' },
            _react2['default'].createElement(
                'p',
                { className: 'credits' },
                'This is an experiment in using AI to make Sahil Lavingia book\'s content more accessible. Ask a question and AI\'ll answer it in real-time:'
            ),
            _react2['default'].createElement(
                'form',
                { onSubmit: handleSubmit, ref: formRef },
                _react2['default'].createElement('textarea', {
                    name: 'question',
                    value: question,
                    onChange: handleTextChange,
                    placeholder: 'Type your question here...',
                    rows: '2',
                    cols: '50'
                }),
                _react2['default'].createElement(
                    'div',
                    { className: 'buttons', style: answer !== "" ? { display: "none" } : {} },
                    _react2['default'].createElement(
                        'button',
                        { disabled: isLoading, type: 'submit', id: 'ask-button' },
                        isLoading ? 'Asking...' : 'Ask question'
                    ),
                    _react2['default'].createElement(
                        'button',
                        { disabled: isLoading, id: 'lucky-button', onClick: handleLuckyClick, style: { background: '#eee', borderColor: '#eee', color: '#444' } },
                        'I\'m feeling lucky'
                    )
                )
            ),
            answer ? _react2['default'].createElement(
                'p',
                { id: 'answer-container', className: '' },
                _react2['default'].createElement(
                    'strong',
                    null,
                    'Answer: '
                ),
                _react2['default'].createElement(
                    'span',
                    { id: 'answer' },
                    displayedAnswer
                ),
                _react2['default'].createElement(
                    'button',
                    { disabled: isLoading, id: 'ask-another-button', onClick: handleAskAnotherClick, style: { display: 'block' } },
                    isLoading ? 'Asking...' : 'Ask another question'
                )
            ) : null
        ),
        _react2['default'].createElement(
            'footer',
            null,
            _react2['default'].createElement(
                'p',
                { className: 'credits' },
                'Project by Gaston Krasny • ',
                _react2['default'].createElement(
                    'a',
                    { href: 'https://github.com/slavingia/askmybook' },
                    'Forked from Sahil Lavingia GitHub'
                )
            )
        )
    );
};

exports['default'] = Home;
module.exports = exports['default'];

Object.defineProperty(exports, '__esModule', {
  value: true
});

var _slicedToArray = (function () { function sliceIterator(arr, i) { var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i['return']) _i['return'](); } finally { if (_d) throw _e; } } return _arr; } return function (arr, i) { if (Array.isArray(arr)) { return arr; } else if (Symbol.iterator in Object(arr)) { return sliceIterator(arr, i); } else { throw new TypeError('Invalid attempt to destructure non-iterable instance'); } }; })();

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var _react = require('react');

var _react2 = _interopRequireDefault(_react);

var QuestionsList = function (props) {
  var _useState = (0, _react.useState)(JSON.parse(props['questions']) || {});

  var _useState2 = _slicedToArray(_useState, 2);

  var questions = _useState2[0];
  var setQuestions = _useState2[1];

  return _react2['default'].createElement(
    'div',
    null,
    _react2['default'].createElement(
      'h2',
      null,
      questions.length,
      '/500 questions answered'
    ),
    _react2['default'].createElement(
      'ul',
      { className: 'queue' },
      questions.map(function (question, index) {
        return _react2['default'].createElement(
          'li',
          { key: index },
          _react2['default'].createElement(
            'strong',
            null,
            question.question
          ),
          _react2['default'].createElement(
            'p',
            null,
            question.answer
          ),
          _react2['default'].createElement(
            'p',
            null,
            _react2['default'].createElement(
              'small',
              null,
              'Asked ',
              question.ask_count,
              ' times'
            )
          )
        );
      })
    )
  );
};

exports['default'] = QuestionsList;
module.exports = exports['default'];

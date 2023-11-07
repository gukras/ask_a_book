function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

var _react = require('react');

var _react2 = _interopRequireDefault(_react);

var _reactDom = require('react-dom');

var _reactDom2 = _interopRequireDefault(_reactDom);

var _propTypes = require('prop-types');

var _propTypes2 = _interopRequireDefault(_propTypes);

var Hello = function (props) {
  return _react2['default'].createElement(
    'div',
    null,
    'Hello ',
    props.name,
    '!'
  );
};

Hello.defaultProps = {
  name: 'David'
};

Hello.propTypes = {
  name: _propTypes2['default'].string
};

document.addEventListener('DOMContentLoaded', function () {
  _reactDom2['default'].render(_react2['default'].createElement(Hello, { name: 'React' }), document.body.appendChild(document.createElement('div')));
});

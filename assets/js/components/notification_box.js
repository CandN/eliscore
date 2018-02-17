import React from 'react'
import PropTypes from 'prop-types'
import Transition from 'react-transition-group/Transition';

const duration = 2000;

const defaultStyle = {
    transition: `opacity ${duration}ms ease-in-out`,
    opacity: 0,
}

const transitionStyles = {
    entering: { opacity: 0 },
    entered:  { opacity: 1 },
};

class NotificationBox extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      in: true
    }
  }

  componentDidMount() {
    setTimeout(() => this.setState({ in: false }), 3000);
  }

  render () {
    const { header, body } = this.props

    return (
      <Transition in={this.state.in} timeout={duration}>
        {(state) => (
          <div className="notification-box" style={{
            ...defaultStyle,
            ...transitionStyles[state]
          }}>
            <h4 className="notification-box__header">{header}</h4>
            <p className="notification-box__body">{body}</p>
          </div>
        )}
      </Transition>
    )
  }
}

NotificationBox.propTypes = {
  header: PropTypes.string.isRequired,
  body: PropTypes.string.isRequired,
}

export default NotificationBox

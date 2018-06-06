import { browserHistory } from 'react-router';
import React from 'react'
import PropTypes from 'prop-types';

export default class Logout extends React.Component {
  static PropTypes = {
    text: PropTypes.string.isRequired
  }

  constructor(props) {
    super(props)
  }

  handleClick() {
    localStorage.setItem('phoenixAuthToken', {})
    browserHistory.push('/sign_in')
  }

  render() {
    const { text } = this.props;
    return (
      <div onClick={this.handleClick} className="score-table__btn-logout-container">
        <div className="score-table__btn-logout">{text}</div>
      </div>
    )
  }
}

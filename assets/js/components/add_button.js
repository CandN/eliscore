import React from 'react'
import PropTypes from 'prop-types';

export default class AddButton extends React.Component {
  static PropTypes = {
    text: PropTypes.string.isRequired
  }

  constructor(props) {
    super(props)
  }

  render() {
    const { text, onclick } = this.props;
    return (
      <div onClick={onclick} className="score-table__btn-new-container">
        <div className="score-table__btn-new">{text}</div>
      </div>
    )
  }
}

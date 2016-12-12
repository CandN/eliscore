import React, { PropTypes } from 'react'

export default class AddButton extends React.Component {
  static PropTypes = {
    text: PropTypes.string.isRequired
  }

  constructor(props) {
    super(props)
  }

  render() {
    const { text } = this.props;
    return (
      <div className="score-table__footer">
        <div className="score-table__btn-new">{text}</div>
      </div>
    )
  }
}

import React, { PropTypes } from 'react'

const Separator = ({ text }) => (
  <div className="col-xs-2 match__separator">{text}</div>
)

Separator.propTypes = {
  text: PropTypes.string.isRequired
}

export default Separator

import React from 'react'
import PropTypes from 'prop-types'

const Separator = ({ text }) => (
  <div className="col-xs-2 match__separator">{text}</div>
)

Separator.propTypes = {
  text: PropTypes.string.isRequired
}

export default Separator

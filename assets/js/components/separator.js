import React from 'react'
import PropTypes from 'prop-types'

const Separator = ({ text }) => (
  <div className="match__separator col-xs-2">
    {text}
  </div>

)

Separator.propTypes = {
  text: PropTypes.string.isRequired
}

export default Separator

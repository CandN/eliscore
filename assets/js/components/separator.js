import React from 'react'
import PropTypes from 'prop-types'

const Separator = ({ text, category_id }) => (
  <div className="col-xs-2">
    <div className="match__separator">
      {text}
    </div>
    <div className="match__category">
      {category_id}
    </div>
  </div>

)

Separator.propTypes = {
  text: PropTypes.string.isRequired
}

export default Separator

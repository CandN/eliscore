import React from 'react'
import PropTypes from 'prop-types';

const Title = ({ text }) => (
  <div className="score-table__title text-center">
    <h3>{text}</h3>
  </div>
)

Title.propTypes = {
  text: PropTypes.string.isRequired
}

export default Title

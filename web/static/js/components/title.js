import React, { PropTypes } from 'react'

const Title = ({ text }) => (
  <div className="score-table__title text-center">
    <h3>{text}</h3>
  </div>
)

Title.propTypes = {
  text: PropTypes.string.isRequired
}

export default Title
